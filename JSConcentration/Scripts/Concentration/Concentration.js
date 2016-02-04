var Concentration = Concentration || {};

var imgDir = 'images/';
var defaultImg = 'face3.png';
var picSet = ['Crab_icon.png', 'Duck_icon.png', 'Elephant_icon.png',
    'Giraffe_icon.png', 'Lion_icon.png', 'Rabbit_icon.png',
    'Rhino_icon.png', 'Tiger_icon.png',
    'Crab_icon.png', 'Duck_icon.png', 'Elephant_icon.png',
    'Giraffe_icon.png', 'Lion_icon.png', 'Rabbit_icon.png',
    'Rhino_icon.png', 'Tiger_icon.png'];
var scrambled = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var clicks = 0;
var uncovered = 0;
var moves = 0;
var prevIndex = -1;
var pause = 800;

$(document).ready(function () {
    Concentration.gameFunctions.setUpForm();
    Concentration.gameFunctions.scrambleImages();

    $('.gameButton').on('click', function () {
        Concentration.gameFunctions.gameButtonClick(this.id);
    });

    $('#newGame').on('click', function () {
        Concentration.gameFunctions.newGame();
    });
	
	$('#header').on('click', function() {
		window.location.href = 'index.html';
	});
});

Concentration.gameFunctions = (function ($) {
    var setUpForm = function () {
        var buttonIndex = 0;
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {
                var button = $('<input class=\'gameButton\' />').attr({ type: 'image', id: buttonIndex, src: imgDir + defaultImg });
                $('#gameButtons').append(button);
                buttonIndex++;
            }
            $('#gameButtons').append('<br>');
        }
    },
    scrambleImages = function () {
        var i = 0;
        do
        {
            var j = Math.floor(Math.random() * 16);
            if (scrambled[j] == '')
            {
                scrambled[j] = picSet[i];
                i++;
            }
        } while (i <= 15);
    },
    gameButtonClick = function (index) {
        if ($('#' + index).attr('src') == imgDir + defaultImg) {
            $('#' + index).attr('src', imgDir + scrambled[index]);
            clicks += 1;
            if (clicks % 2 == 0 && uncovered % 2 == 0) {
                moves++;
                var moveTxt = moves == 1 ? '1 Move' : moves + ' Moves';
                $('#moves').text(moveTxt);
                if (scrambled[prevIndex] == scrambled[index]) {
                    uncovered += 2;
                }
                else {
                    doPause(pause, index, prevIndex);
                }
            }
            prevIndex = index;
        }
	    // check for complete gameButton
	    if(uncovered == picSet.length) {
		    var msg = 'You took ' + moves + ' moves to complete the puzzle.\n\n';
		    switch(true) {
			    case(moves <= 13):
				    msg += 'Brilliant!!';
				    break;
			    case(moves > 13 && moves <= 15):
				    msg += 'Well done!';
				    break;
			    case(moves > 15 && moves <= 17):
				    msg += 'Nice job.';
				    break;
			    case(moves > 17 && moves <= 19):
				    msg += 'Not bad.';
				    break;
			    case(moves > 19 && moves <= 21):
				    msg += 'Well...we can\'t all be geniuses.';
				    break;
			    case(moves > 21):
				    msg += 'You might want to get checked for Alzheimers.';
				    break;
		    }
		    alert(msg);
	    }
    },
    newGame = function () {
        scrambled = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
        clicks = 0;
        uncovered = 0;
        moves = 0;
        prevIndex = -1;
        scrambleImages();
        $('.gameButton').each(function () {
            $(this).attr('src', imgDir + defaultImg);
        });
        $('#moves').text('0 Moves');
    },
    doPause = function (miliseconds, curr, prev) {
        setTimeout(function () {
            // images don't match. set back to default
            $('#' + curr).attr('src', imgDir + defaultImg);
            $('#' + prev).attr('src', imgDir + defaultImg);
        }, miliseconds);
    }

    //public functions
    return {
        setUpForm: setUpForm,
        scrambleImages: scrambleImages,
        gameButtonClick: gameButtonClick,
        newGame: newGame,
        doPause: doPause
    };
})(jQuery);