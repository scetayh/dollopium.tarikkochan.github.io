function submit() {
    var testerName = document.getElementById("testerName").value;
    var testerUnit = document.getElementById("testerUnit").value;

    if (window.confirm("确认提交答卷？\n确认后将不允许更改任何答案。")) {
        while (testerName == null || testerName == "") {
            testerName = prompt("姓名不可为空。请检查你输入的字符并再次提交。")
        }

        while (testerUnit == null || testerUnit == "") {
            testerUnit = prompt("单位不可为空。请检查你输入的字符并再次提交。")
        }

        var fraction = 0;
        var endOfAnswerSingle;

        console.log("SINGLE QUESTIONS");
        var questionSingleAll = document.getElementsByClassName("questionSingle");
        // for i in every single questions
        for (var i = 1; i <= questionSingleAll.length; i++) {
            var answerSingle = document.getElementsByName("answer" + (i));
            console.log("option number: " + answerSingle.length);
            // for j in every options
            for (var j = 0; j < answerSingle.length; j++) {
                endOfAnswerSingle = i;
                // if correct
                if (answerSingle[j].value == "correct") {
                    // if checked, ++fraction
                    if (answerSingle[j].checked) {
                        console.log("question " + i + " answer " + j + " correct and checked, fraction is " + ++fraction);
                        //fraction++;
                    }
                    // if not check, break circulation j
                    else {
                        console.log("question " + i + " answer " + j + " correct and not checked, fraction is " + fraction);
                        break;
                    }
                }
                // if incorrect
                else {
                    // if checked, break circulation j
                    if (answerSingle[j].checked) {
                        console.log("question " + i + " answer " + j + " incorrect and checked, fraction is " + fraction);
                        break;
                    }
                    // if not checked, continue
                    else {
                        console.log("question " + i + " answer " + j + " incorrect and not checked, fraction is " + fraction);
                        //continue;
                    }
                }
            }
        }

        console.log("MULTIPLE QUESTIONS");
        var questionMultipleAll = document.getElementsByClassName("questionMultiple");
        var questionMultipleThisFraction;
        // for i in every multiple questions
        for (var i = endOfAnswerSingle + 1; i <= endOfAnswerSingle + questionMultipleAll.length; i++) {
            console.log("total question number: " + i);
            questionMultipleThisFraction = 1;
            var answerMultiple = document.getElementsByName("answer" + (i));
            // fot j in every options
            console.log("option number: " + answerMultiple.length);
            for (var j = 0; j < answerMultiple.length; j++) {
                // if correct
                if (answerMultiple[j].value == "correct") {
                    // if checked, continue
                    if (answerMultiple[j].checked) {
                        console.log("question " + i + " answer " + j + " correct and checked, so far fraction of this question is " + questionMultipleThisFraction);
                        //continue;
                    }
                    // if not checked, break circulation j
                    else {
                        questionMultipleThisFraction = 0;
                        console.log("question " + i + " answer " + j + " correct and not checked, so far fraction of this question is " + questionMultipleThisFraction);
                        break;
                    }
                }
                // if incorrect
                else {
                    // if checked, break circulation j
                    if (answerMultiple[j].checked) {
                        questionMultipleThisFraction = 0;
                        console.log("question " + i + " answer " + j + " incorrect and checked, so far fraction of this question is " + questionMultipleThisFraction);
                        break;
                    }
                    // if not checked, continue
                    else {
                        console.log("question " + i + " answer " + j + " incorrect and unchecked, so far fraction of this question is " + questionMultipleThisFraction);
                        //continue;
                    }
                }
            }
            // break then here, end of this question
            console.log("so fraction of question " + i + " is " + questionMultipleThisFraction);
            fraction = fraction + questionMultipleThisFraction;
            console.log("now fraction is " + fraction);
        }

        var dateEnd = new Date();
        var timestampEnd = dateEnd.getTime();
        var timestampDuration = timestampEnd - timestampStart;

        while (true) {
            alert("☆ 测试结果\n\n姓名　" + testerName + "\n单位　" + testerUnit + "\n\n开始时间　" + dateStart.toLocaleString() + "\n结束时间　" + dateEnd.toLocaleString() + "\n用时　" + parseInt(timestampDuration / 1000 / 60) + "分钟\n\n分数　" + fraction + "\n\n截图或拍摄本页以存储测试记录。");
        }
    }
    else {
        return false;
    }
}