function answerLinks() {
  const links = document.querySelectorAll(".user-answer-link")

  links.forEach(function(link) {
    link.addEventListener("mouseover", function(){
      link.setAttribute("style","color:pink;")
    });
    link.addEventListener("mouseout", function(){
      this.removeAttribute("style","color:pink;")
    });
  });

};
window.addEventListener('load', answerLinks)