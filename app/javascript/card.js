const pay = () => {
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); // PAY.JP公開鍵
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
    e.preventDefault(); // Railsへの送信を一旦止める
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      form.submit(); // 暗号を合体させてから、Railsへ送信
    });
  });
};

window.addEventListener("turbo:load", pay);