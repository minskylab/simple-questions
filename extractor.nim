import httpClient
import strutils

const questionURL: string = "http://challenge.i2a2.ca/question"
const totalRequests: int = 60
const fileName: string = "QUESTIONS.md"

var client = newHttpClient()
var questions: seq[string] = @[]

for i in 1..totalRequests:
    let q = client.getContent(questionURL)
    if not (q in questions):
        questions.add(q)
        echo q
    else:
        echo "."


echo questions.len()

let f = open(fileName, fmWrite)

f.writeLine("## I2A2 Questions\n")
f.writeLine("### Questions")
f.writeLine("This questions were scraped from " & questionURL & "\n")

for q in questions:
    f.writeLine("> " & q.replace("\"", ""))

f.close()
