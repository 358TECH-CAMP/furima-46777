const pay = () => {
  // カリキュラム通り：gonを使って公開鍵（public_key）を読み込む
  const payjp = Payjp(gon.public_key); 

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // フォームの指定した場所に、PAY.JPが用意した入力欄を埋め込む
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
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
