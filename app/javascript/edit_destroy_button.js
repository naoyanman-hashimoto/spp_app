function showLists() {
  const button = document.querySelectorAll("#button");
  const lists   = document.querySelectorAll('.question-link')


  button.forEach(function(button) {
    button.addEventListener("mouseover", function(){
      this.setAttribute("style","color:red;")
    });
    button.addEventListener("mouseout", function(){
      this.removeAttribute("style","color:red;")
    });
  });

    lists.forEach(function(list) {
      list.addEventListener("mouseover", function(){
        this.setAttribute("style","color:#FFBEDA;")
      });
      list.addEventListener("mouseout", function(){
        this.removeAttribute("style","color:FFBEDA;")
      });
    });

};
window.addEventListener('load', showLists)