// app/javascript/item_price.js
const price = () => {
  const priceInput = document.getElementById("item-price"); // 金額inputのid
  const addTaxDom = document.getElementById("add-tax-price"); // 手数料表示
  const profitDom = document.getElementById("profit"); // 利益表示

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const tax = Math.floor(inputValue * 0.1);
      const profit = inputValue - tax;

      addTaxDom.innerHTML = tax;
      profitDom.innerHTML = profit;
    });
  }
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);


// window.addEventListener('turbo:load', () => {
//   console.log("OK");
// });

const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  console.log(priceInput.value);
});
