(: XQuery comment :)

(:
Item 1. List Names of students and their mentors.

<NS>

{


let $dataStudent := doc("data/Student.xml")
let $dataPerson := doc("data/Person.xml")


for $s in $dataStudent/Students/Student
let $ps := $dataPerson/Persons/Person[ID=$s/StudentID]
let $pm := $dataPerson/Persons/Person[ID=$s/MentorID]
order by $ps/Name
return <E>
       <student_Name>{data($ps/Name)}</student_Name>
       <mentor_Name>{data($pm/Name)}</mentor_Name>
       </E>
}
</NS>

:)


(: Item 2. For each classification, list the classification and the
 average GPA of students with that classification. Your query should
 not use any constants, such as "Freshman".  

<NS>

{
let $dataStudent := doc("data/Student.xml")
let $dataPerson := doc("data/Person.xml")

for $c in distinct-values($dataStudent/Students/Student/Classification)
let $count := count($dataStudent/Students/Student[Classification=$c])
let $gpaSum := sum($dataStudent/Students/Student[Classification=$c]/GPA)

return <E>
       <Classification>{data($c)}</Classification>
       <AverageGPA>{$gpaSum div $count}</AverageGPA>
       </E>
}
</NS>

:)

(:
Item 3. For each enrolled student, list his/her name and his/her
mentor's name.


<NS>

{
let $dataStudent := doc("data/Student.xml")
let $dataPerson := doc("data/Person.xml")
let $dataEnrollment := doc("data/Enrollment.xml")


for $e in distinct-values($dataEnrollment/Enrollments/Enrollment/StudentID)

let $s := $dataStudent/Students/Student[StudentID=$e]
let $ps := $dataPerson/Persons/Person[ID=$e]
let $pm := $dataPerson/Persons/Person[ID=$s/MentorID]
order by $ps/Name
return <E>
       <student_Name>{data($ps/Name)}</student_Name>
       <mentor_Name>{data($pm/Name)}</mentor_Name>
       </E>

}
</NS>

:)




(:
Item 4. List the Names of students who have at least one A in courses
they are enrolled in. (Do not consider A- as an A.)


<NS>
{
let $dataStudent := doc("data/Student.xml")
let $dataPerson := doc("data/Person.xml")
let $dataEnrollment := doc("data/Enrollment.xml")

for $e in distinct-values( $dataEnrollment/Enrollments/Enrollment[Grade="A"]/StudentID)
for $sid in $e
let $sName := data($dataPerson/Persons/Person[ID=$sid]/Name)

order by $sName
return <E>{$sName} </E>

}
</NS>

:)


(:
Item 5. List the course codes of courses that are prerequisites for the course 'CS311'.


<NS>
{
let $dataCourse := doc("data/Course.xml")

for $preReq in $dataCourse//Course[CourseCode="CS311"]/PreReq
return <E>{data($preReq)}</E>

}
</NS>

:)

(:
Item 6. Restructure Course.xml Student.xml by classification. There
should be one element per classification in which the remaining
information about students should be included in one element per
student.



<Students>
{
let $dataStudent := doc("data/Student.xml")
let $classifications := distinct-values($dataStudent/Students/Student/Classification)
for $c in $classifications
return <Classification type="{$c}">
	<type>{$c}</type>
	{
	   for $s in $dataStudent/Students/Student[Classification=$c]
	   return <Student>
	   	  {$s/StudentID}
	   	  {$s/GPA}
	   	  {$s/MentorID}
	   	  {$s/CreditHours}
	   	   </Student>
 	}
	</Classification>

}
</Students>
:)


(:
<bib>
{
	for $book in doc("data/books.xml")//book
	let $authors := $book/author
	return 
	<book>
		<authors>
		{
			for $author in $authors
			return $author
		}
		</authors>
		{$book/title}
		{$book/year}
		{$book/price}
	</book>
}
</bib>

:)





<em>
{
let $books := doc("data/books.xml")//book
let $lang := distinct-values($books/title/@lang)

for $ulang in $lang
return 
<language type="{$ulang}">
{	  
	  for $b in $books[title/@lang=$ulang]
	  return $b
}
</language>
}
</em>