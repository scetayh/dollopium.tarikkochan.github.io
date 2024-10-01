#!/bin/bash

set -e

function printOptionOrder() {
    if [ $1 = 1 ]; then
        printf A
    elif [ $1 = 2 ]; then
        printf B
    elif [ $1 = 3 ]; then
        printf C
    elif [ $1 = 4 ]; then
        printf D
    elif [ $1 = 5 ]; then
        printf E
    elif [ $1 = 6 ]; then
        printf F
    elif [ $1 = 7 ]; then
        printf G
    elif [ $1 = 8 ]; then
        printf H
    elif [ $1 = A ]; then
        printf 1
    elif [ $1 = B ]; then
        printf 2
    elif [ $1 = C ]; then
        printf 3
    elif [ $1 = D ]; then
        printf 4
    elif [ $1 = E ]; then
        printf 5
    elif [ $1 = F ]; then
        printf 6
    elif [ $1 = G ]; then
        printf 7
    elif [ $1 = H ]; then
        printf 8
    fi
}

# printOption <question order> radio|checkbox correct|incorrect <option order> <content>
# example: printOption 1 radio incorrect "A. 2"
function printOption() {
    printf '        <label id="'
    printf $1
    printf '"><input type="'
    printf $2
    printf '" name="answer'
    printf $1
    printf '" value="'
    printf $3
    printf '" />'
    printf $(printOptionOrder $4)
    printf '. '
    printf "$5"
    printf '</label>'
    echo
    printf '        <br />'
    echo
    return 0
}

# printQuestionHead questionSingle|questionMultiple <order> <question>
function printQuestionHead() {
    printf '    <fieldset class="'
    printf $1
    printf '">'
    echo
    printf '        <p id="'
    printf $2
    printf '">'
    printf $2
    printf '. '
    printf "$3"
    printf '</p>'
    echo
}

function printQuestionTail() {
    printf '    </fieldset>'
    echo
    echo
}

function questionOrderPP() {
    questionOrder=$((questionOrder + 1))
}

function optionOrderPP() {
    optionOrder=$((optionOrder + 1))
}

function main() {
export lineNumber="$(wc -l < $file)"

for ((i=1; i<=$((lineNumber + 1)); i++)); do
        export optionOrder=0
        export iLineContent="$(sed -n ${i}p $file)"

        if [[ "$iLineContent" = QUESTION_ORDER* ]]; then
            questionOrderPP
            printQuestionHead question$questionType $questionOrder "${iLineContent#*QUESTION_ORDER}"

            for ((j=$((i + 1)); j<=$((lineNumber + 1)); j++)); do
                export jLineContent="$(sed -n ${j}p $file)"
                if [[ "$jLineContent" = QUESTION_OPTION* ]]; then
                    optionOrderPP
                    #echo $(printOptionOrder $optionOrder)
                    #echo $answerOrder
                    if [[ "$answerOrder" =~ "$(printOptionOrder $optionOrder)" ]]; then
                        optionCorrectness=correct
                    else
                        optionCorrectness=incorrect
                    fi
                    printOption $questionOrder $optionType $optionCorrectness $optionOrder "${jLineContent#*QUESTION_OPTION}"
                    unset optionCorrectness
                elif [[ "$jLineContent" = QUESTION_ORDER* ]]; then
                    unset optionOrder
                    break
                else
                    export answerOrder=$jLineContent
                fi
            done
            printQuestionTail
        fi
    done
}

sed -n 1,70p sources/html/index.html

export questionOrder=0


echo "    <h2>单选题</h2>"
echo
export file="question-single.txt"
export questionType=Single
export optionType=radio
main

echo "    <h2>多选题</h2>"
echo
export file="question-multiple.txt"
export questionType=Multiple
export optionType=checkbox
main

sed -n 115,121p sources/html/index.html