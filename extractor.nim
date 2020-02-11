import httpClient
import strutils
import strformat

const questionURL: string = "http://challenge.i2a2.ca/question"
const totalRequests: int = 1000
const overflowFails: int = 160
const fileName: string = "QUESTIONS.md"

var client = newHttpClient()
var questions: seq[string] = @[]

var totalFails: int = 0
for i in 1..totalRequests:
    let q = client.getContent(questionURL)
    if not (q in questions):
        totalFails = 0
        questions.add(q)
        echo q
    else:
        totalFails += 1
        if totalFails > overflowFails:
            break
        echo "."


let totalQuestions: int = questions.len()
echo totalQuestions

let f = open(fileName, fmWrite)

f.writeLine("## I2A2 Questions\n")
f.writeLine("### Questions")
f.writeLine("This questions were scraped from " & questionURL & "\n")
f.writeLine(fmt"`Total questions: {totalQuestions}`" & "\n")

for i, q in questions:
    f.writeLine("> " & q.replace("\"", "") & "\n")

f.close()
