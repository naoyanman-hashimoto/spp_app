function chart(){
  var ctx = document.getElementById("myChart").getContext('2d');

    var myChart = new Chart(ctx, {
      type: 'horizontalBar',
      data: {
        label: [],
        datasets: [{
          label: 'けいけんち',
          data: [gon.experience_point,gon.thresold],
          backgroundColor: [
            'red',
          ]
        }]
      },
      options: {
        title: {
          // display: true,
          // text: '経験値指標'
        },
        legend: {
        },
        scales: {
          xAxes: [{
            ticks: {
              beginAtZero:true,
              max: gon.thresold,
              fontSize: 8
            }
          }],
        }
      }
    });

};
  window.addEventListener('load', chart)