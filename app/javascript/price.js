function price (){
  const itemPrice = document.getElementById("item-price");
    itemPrice.addEventListener('input', () => {
      
      const inputValue = itemPrice.value;
      const tax = Math.floor(inputValue * 0.1);
      const profitValue = Math.floor(inputValue - tax);

      const addTaxPrice = document.getElementById("add-tax-price");
      addTaxPrice.innerHTML = tax.toLocaleString('ja-JP');
      var taxPrice = addTaxPrice.innerHTML;

      const profit = document.getElementById("profit");
      profit.innerHTML = profitValue.toLocaleString('ja-JP');
      profitValueResult = profit.innerHTML

    });
}

window.addEventListener('load', price)
