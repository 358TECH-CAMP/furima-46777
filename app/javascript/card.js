const pay = () => {
  // カリキュラム通り：gonを使って公開鍵（public_key）を読み込む
   // 1. 公開鍵が準備できていない場合は何もしない（gonエラー対策）
  if (typeof gon === 'undefined' || !gon.public_key) return;

  // 2. そもそもフォームがないページでは何もしない
  const form = document.getElementById('charge-form');
  if (!form) return;

  // 3. すでに入力欄がある場合は、新しく作らない（「既にインスタンス化...」エラー対策）
  const numberForm = document.getElementById('number-form');
  if (numberForm && numberForm.innerHTML !== "") return;

  const payjp = Payjp(gon.public_key); 

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // フォームの指定した場所に、PAY.JPが用意した入力欄を埋め込む
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (!response.error) {
        const token = response.id;
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      }
      // // これを行うとトークンが正しく送信されないケースがあるため、numberElement.clear() などの clear処理を削除します。
      // numberElement.clear();
      // expiryElement.clear();
      // cvcElement.clear();

      form.submit();
    });
  });
};

// ページ読み込み時と、バリデーションエラーでページが再描画された時、両方で発火させる
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
