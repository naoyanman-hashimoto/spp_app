function countdowntimer(){

  const startingMinites = 5;
  let time = startingMinites * 60;

  const countdownEL = document.getElementById('set-timer');

  const timerID = setInterval(updateCountdown, 1000);

  function updateCountdown(){
    const minites = Math.floor(time / 60);
    let seconds = time % 60;

    seconds = seconds < 10 ? '0' + seconds : seconds;

    countdownEL.innerHTML = `残り時間${minites}分${seconds}秒`;
    time--;
    if (time === 0) {
    alert('じかんです!よくばんばりました✨\nきょうかしょをみるか、おとなのひとにきいてみてね^^');
    clearInterval(timerID);
    };
  };
};
  window.addEventListener('load', countdowntimer)