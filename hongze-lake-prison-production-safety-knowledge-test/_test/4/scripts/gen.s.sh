#!/bin/bash

rm -fv index.html

function PrintHead() {
    cat head.txt
    echo
}

function PrintTail() {
    cat tail.txt
    echo
}

# PrintQuestionHead <题号> <题干>
function PrintQuestionHead() {
    printf '    <fieldset class="question">'
    echo
    printf '        <p id="'
    printf $1
    printf '">'
    printf "$2"
    printf '</p>'
    echo
}

function PrintQuestionTail() {
    printf '    </fieldset>'
    echo
    echo
}

# PrintOption <题号> <分值> <内容>
function PrintOption() {
    if [ $2 = 1 ]; then
        printf '        <label id="'
        printf $1
        printf '"><input type="radio" name="answer'
        printf $1
        printf '" value="'
    else
        printf '        <label><input type="radio" name="answer'
        printf $1
        printf '" value="'
    fi
    printf $2
    printf '" />'
    printf "$3"
    printf '</label>'
    echo
    printf '        <br />'
    echo
}

PrintHead

PrintQuestionHead 1 "1. “长风破浪会有时, 直挂云帆济沧海。” 出自下列哪一首诗？"
PrintOption 1 1 "A. 《行路难》"
PrintOption 1 0 "B. 《蜀道难》"
PrintOption 1 0 "C. 《长恨歌》"
PrintQuestionTail

PrintQuestionHead 2 "2. “长风破浪会有时, 直挂云帆济沧海。” 出自下列哪一首诗？"
PrintOption 2 1 "A. 《行路难》"
PrintOption 2 0 "B. 《蜀道难》"
PrintOption 2 0 "C. 《长恨歌》"
PrintQuestionTail

PrintTail