const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // 出品ページ以外では実行しない

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    // 手数料（10%）を計算し、小数点以下を切り捨てる
    const tax = Math.floor(inputValue * 0.1);
    // 販売利益を計算（価格 - 手数料）
    const profitValue = Math.floor(inputValue - tax);

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 計算結果を表示する
    addTaxDom.innerHTML = tax.toLocaleString(); // カンマ区切りは任意ですが、数値を入れる
    profitDom.innerHTML = profitValue.toLocaleString();
  });
};

// ページが読み込まれた時と、バリデーションエラーで戻ってきた時に実行
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);