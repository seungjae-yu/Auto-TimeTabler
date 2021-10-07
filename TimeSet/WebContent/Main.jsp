<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Collections" %>
<%@ page import="javax.swing.JCheckBox" %>
<%@ page import="javax.swing.JRadioButton" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Main</title>
</head>
<body>
<%!
/////////////
public class Main {
	List<Schedule> listresult;
	List<Course> mCourseList = new ArrayList<Course>();
	
	public String courseConfig = null;

	public void main(String[] args) {
		Main main = new Main();
	}

	public Main() {
		
		mCourseList = getDumpData();
		System.out.println(mCourseList.size());
		Scheduling mscheduleing = new Scheduling(mCourseList);
		List<Schedule> result = mscheduleing.getComplementedSchedule();
		setResult(result);
		//for(int n= 0 ; n< result.size(); n++){
		//	System.out.println("완성된 시간표 _ " + n);
		//	System.out.println(result.get(n).toString());
		//}
	}
	public void setResult(List<Schedule> result) {
		listresult = result;
	}

	public List<Schedule> getResult() {
		return listresult;
	}
	
	public List<Course> getDumpData(){
		
		List<Course> mData = new ArrayList<Course>();
		String[] lineSection = null;
		//String filePath = "F:\\project\\java\\TimeTabler\\src\\com\\TimeTabler\\Model\\컴퓨터정보공학과 , 컴퓨터정보공학";
		//String filePath="C:\\Users\\SeungJae\\Desktop\\Timetabler for S\\src\\com\\lanace\\model\\컴퓨터.txt";
		String filePath="C:\\Users\\SeungJae\\Desktop\\TimeSet\\TimeSet\\WebContent\\컴퓨터.txt";
		String line = "line";
		try {
			File myfile = new File(filePath);
			FileReader fileReader = new FileReader(myfile);
			BufferedReader reader = new BufferedReader(fileReader);
			
			while ((line = reader.readLine()) != null) {
				lineSection = line.split("\t");
				if (lineSection.length > 9){
					mData.add(new Course("TEST", lineSection[0],
							lineSection[1], lineSection[2], lineSection[3],
							lineSection[4], lineSection[5], 0, lineSection[6],
							lineSection[7], lineSection[8], lineSection[9]));
				}
				else{
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mData;
	}	
}

/////////////////////////////////////
////////////////////////Course/////////////////
//////////////////////////////////////

public class Course implements Comparable<Course>{
	
	public static final int WEEKCOUNT = 7;
	public static final int PERIODCOUNT = 13;
	public final String[] colName = {"학수번호","과목명","학년","학점","과목구분","시간(강의실)","교수","평가방식","비고"};
	public HashMap<String, String> CourseList = new HashMap<String, String>();
	
	private String Category;// 카테고리
	private String Number;  // 학수 번호
	private String Group;	// 분반그룹
	private String Name;	// 과목이름
	private String Level;	// 학년
    private String Credit;	//학점
    private String Section;	// 과목구분
    private int Preference;	// 선호도 점수
    private String SubjectTableTxt;	//
    private String[][] SubjectTable = new String[WEEKCOUNT][PERIODCOUNT];  // 시간, 강의실
    private String Propesser;	// 교수
    private String Evaluation;	// 평가방식
    private String Note;	// 비고
    
    /**
     * 생성자.
     * 
     * */
    public Course(String Category, String Number, String Group , String Name
    				,String Level, String Credit, String Section, int Preference
    				,String SubjectTableTxt, String Propesser
    				,String Evaluation, String Note){
    	setCategory(Category);
    	setNumber(Number);
    	setGroup(Group);
    	setName(Name);
    	setLevel(Level);
    	setCredit(Credit);
    	setSection(Section);
    	setPreference(Preference);
    	setSubjectTableTxt(SubjectTableTxt);
    	setPropesser(Propesser);
    	setEvaluation(Evaluation);
    	setNote(Note);
    
    	setSubjectTable(SubjectTableTxt);	// SubjectTableTxt.ToTable();
    }
    
    
    public Course(Course course) {
    	setCategory(course.getCategory());
    	setNumber(course.getNumber());
    	setGroup(course.getGroup());
    	setName(course.getName());
    	setLevel(course.getLevel());
    	setCredit(course.getCredit());
    	setSection(course.getSection());
    	setPreference(course.getPreference());
    	setSubjectTableTxt(course.getSubjectTableTxt());
    	setPropesser(course.getPropesser());
    	setEvaluation(course.getEvaluation());
    	setNote(course.getNote());
    
    	setSubjectTable(course.getSubjectTableTxt());	// SubjectTableTxt.ToTable();
	}


	/**
     * 겹치면 false, 겹치지 않으면 true
     * @param newCourse 확인할 Course
     * @return  겹치면 false, 겹치지 않으면 true
     * */
    public boolean isNotOverlapable(Course newCourse){
    	for(int WeekCount = 0; WeekCount < Course.WEEKCOUNT; WeekCount++){
			for(int PeriodCount = 0; PeriodCount < Course.PERIODCOUNT; PeriodCount++){
				if(SubjectTable[WeekCount][PeriodCount] == null){
					continue;
				}
				if(newCourse.SubjectTable[WeekCount][PeriodCount] == null){
					continue;
				}
				return false;
			}
		}
    	return true;
    }
    
    /**
     * 괄호 사이에 있는 문자열을 반환한다. 
     * 일반적인 시간표에서 강의실을 뜻함
     * @param str 강의실과 요일, 시간이 나와있는 문자열
     * @return 괄호 사이에 있는 문자열 (강의실) 을 반환한다.
     * */
    public String getLectureRoom(String str){
    	return str.substring(str.indexOf('('), str.indexOf(')') + 1);
    }
    
    public String getCategory(){
    	return Category;
    }
    public void setCategory(String Category){
    	this.Category = Category;
    }
    public String getNumber(){
    	return Number;
    }
    public void setNumber(String Number){
    	this.Number = Number;
    }
    public String getGroup(){
    	return Group;
    }
    public void setGroup(String Group){
    	this.Group = Group;
    }
    public String getName(){
    	return Name;
    }
    public void setName(String Name){
    	this.Name = Name;
    }
    public String getLevel(){
    	return Level;
    }
    public void setLevel(String Level){
    	this.Level = Level;
    }
    public String getCredit(){
    	return Credit;
    }
    public void setCredit(String Credit){
    	this.Credit = Credit;
    }
    public String getSection(){
    	return Section;
    }
    public void setSection(String Section){
    	this.Section = Section;
    }
    public int getPreference(){
    	return Preference;
    }
    public void setPreference(int Preference){
    	this.Preference = Preference;
    }
    public String getSubjectTableTxt(){
    	return SubjectTableTxt;
    }
    public void setSubjectTableTxt(String SubjectTableTxt){
    	this.SubjectTableTxt = SubjectTableTxt;
    }
    public String[][] getSubjectTable(){
    	return SubjectTable;
    }
    public void setSubjectTable(String[][] SubjectTable){
    	this.SubjectTable = SubjectTable;
    }
    public void setSubjectTable(String SubjectTableTxt){
    	String [][]tempTable = new String[Course.WEEKCOUNT][Course.PERIODCOUNT];
    	String []diffrentLecture = SubjectTableTxt.split("/");
    	int weekCount = 0;	// 강의 요일
    	
    	for(int LectureCount = 0; LectureCount < diffrentLecture.length; LectureCount++){
    		for(int charIndex = 0; charIndex < diffrentLecture[LectureCount].length(); charIndex++){
    			switch (diffrentLecture[LectureCount].charAt(charIndex)) {
    			case '월':
    				weekCount = 1;
					break;
    			case '화':
    				weekCount = 2;
    				break;
    			case '수':
    				weekCount = 3;
    				break;
    			case '목':
    				weekCount = 4;
    				break;
    			case '금':
    				weekCount = 5;
    				break;
    			case '토':
    				weekCount = 6;
    				break;
    			case '셀':
    				weekCount = 0;
    				break;
    			case ',':
    				
    				break;
    			case '(':
    				weekCount = -1;
    				break;
				default:
					if(isInteger(diffrentLecture[LectureCount].charAt(charIndex))){
						if(isInteger(diffrentLecture[LectureCount].charAt(charIndex+1))){
							// 10 ~ 12 교시
							setPeriod(tempTable, weekCount, 
									Integer.parseInt("" 
							+ diffrentLecture[LectureCount].charAt(charIndex)
							+ diffrentLecture[LectureCount].charAt(++charIndex))
							, Name + "\n" + getLectureRoom(diffrentLecture[LectureCount]));
						}
						else{
							// 1~9교시
							setPeriod(tempTable, weekCount, 
									Integer.parseInt("" 
							+ diffrentLecture[LectureCount].charAt(charIndex))
							, Name + "\n" + getLectureRoom(diffrentLecture[LectureCount]));
						}
					}
					break;
				}
    			
    			// (가 나오면 다음 공간으로 넘어간다.
    			if(weekCount == -1)
    				break;
    		}
    	}
    	
    	this.SubjectTable = tempTable;
    }
    
    public void setPeriod(String [][]Table,int weekTime, int periodTime, String data){
    	Table[weekTime][periodTime] = data;
    }
    
    public String getPropesser(){
    	return Propesser;
    }
    public void setPropesser(String Propesser){
    	this.Propesser = Propesser;
    }
    public String getEvaluation(){
    	return Evaluation;
    }
    public void setEvaluation(String Evaluation){
    	this.Evaluation = Evaluation;
    }
    public String getNote(){
    	return Note;
    }
    public void setNote(String Note){
    	this.Note = Note;
    }

    public String[] toArray(){
    	String[] compoment = new String[9];
    	compoment[0] = Number;
    	compoment[1] = Name;
    	compoment[2] = Level;
    	compoment[3] = Credit;
    	compoment[4] = Section;
    	compoment[5] = SubjectTableTxt;
    	compoment[6] = Propesser;
    	compoment[7] = Evaluation;
    	compoment[8] = Note;
    	return compoment;
    }
    
	@Override
	public int compareTo(Course o) {
		return Name.compareTo(((Course)o).Name);
	}
	
	/**
	 * char형이 숫자인지 아닌지를 확인하여 반환한다.
	 * @param character 문자가 숫자인지 확인
	 * @return  character가 숫자이면 true, 아니면 false 를 반환한다.
	 * */
	public boolean isInteger(char character){
		int number = (int)character - 48;
		if(number > 9 || number <0)
			return false;
		return true;
	}
	
	@Override
	public String toString(){
		String Result = "";
		
		Result += "카테고리: " + Category + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "학수번호: " + Number + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "분반그룹: " + Group + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "과목이름: " + Name + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "학년: " + Level + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "학점: " + Credit + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "강의실 and 시간: " + SubjectTableTxt + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "교수: " + Propesser + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "평가방식: " + Evaluation + "&nbsp&nbsp&nbsp&nbsp&nbsp";
		Result += "비고: " + Note + "&nbsp&nbsp&nbsp&nbsp&nbsp";		
		Result += "강의실: ";
		for(int weekIndex = 0; weekIndex < WEEKCOUNT; weekIndex++){
			for(int periodIndex = 0; periodIndex < PERIODCOUNT; periodIndex++){
				if(SubjectTable[weekIndex][periodIndex] != null){
					Result += "[" + weekIndex + ", " + periodIndex + "] " + SubjectTable[weekIndex][periodIndex] + "&nbsp&nbsp&nbsp&nbsp&nbsp";
				}
			}
		}
		Result+="<br>";
		return Result;
	}
}





///////////////////////
///////////Schedule///////////////////
///////////////

public class Schedule implements Comparator<Schedule>{
	private List<Course> Courses;
	
	
	public Schedule(){
		Courses = new ArrayList<Course>();
	}
	public Schedule(Course newCourse){
		Courses = new ArrayList<Course>();
		Courses.add(newCourse);
	}
	
	public Schedule(Schedule newSchedule) {
		Courses = new ArrayList<Course>(newSchedule.getCourses());
	}
	public boolean add(Course newCourse){
		if(isAddible(newCourse)){
			Courses.add(newCourse);
			return true;
		}
		return false;
	}
	
	/**
	 * 시간표를 만들기 위한 테이블을 반환한다.
	 * 현제 Courses List에 저장된 값의 일정을 모두 합하여 String [][] type을 반환.
	 * @return String[][]
	 * */
	public String[][] getTimeTable(){
		String [][]Result = new String[Course.PERIODCOUNT -1][Course.WEEKCOUNT+1];
		
		for(int TotalCount = 0; TotalCount < Courses.size(); TotalCount++){
			for(int periodIndex = 0; periodIndex < Course.PERIODCOUNT -1; periodIndex++){
				for(int weekIndex = 1; weekIndex < Course.WEEKCOUNT - 1; weekIndex++){
					if(Courses.get(TotalCount).getSubjectTable()[weekIndex][periodIndex+1] != null){
						Result[periodIndex][weekIndex+1] = Courses.get(TotalCount).getSubjectTable()[weekIndex][periodIndex+1];
					}
				}
				if(Courses.get(TotalCount).getSubjectTable()[0][periodIndex] != null){
					Result[periodIndex][1] = Courses.get(TotalCount).getSubjectTable()[0][periodIndex];
				}
			}
		}
		
		return Result;
	}
	
	public boolean isAddible(Course newCourse){
		for(int SelectedCourse = 0; SelectedCourse < Courses.size(); SelectedCourse++){
			if(!Courses.get(SelectedCourse).isNotOverlapable(newCourse)){
				return false;
			}
		}
		
		return true;
	}
	
	public List<Course> getCourses(){
		return Courses;
	}
	
	public int getScore(){
		int total = 0;
		for(Course course : Courses){
			total += course.getPreference();
		}
		
		return total;
	}
	
	@Override
	public String toString() {

		String result = "";
		
		for(int index = 0; index < Courses.size(); index++){
			result += Courses.get(index).toString() + "\n";
		}
		
		return result;
	}
	@Override
	public int compare(Schedule arg0, Schedule arg1) {
		return arg1.getScore() - arg0.getScore();
	}
}
/////////////////
///////////////////////////////Scheduling////////
/////////////////


public class Scheduling {
	private List<Course> SelectedCourseList;
	private List<List<Course>> SortedCourseList;
	private List<Schedule> ComplementedSchedule;
	
	
	/** 선택된 시간표를 과목명 정렬후 과목별로 분류 */
	public Scheduling(List<Course> Courses){
		SelectedCourseList = new ArrayList<Course>(Courses);
		
		Collections.sort(SelectedCourseList);	// 과목명으로 정렬
		SortedCourseList = new ArrayList<List<Course>>();
		setSortToCourseName();	// 과목별 분류
		ComplementedSchedule = getSchedule();	// 시간표 만듬
	}
	
	public List<Schedule> getComplementedSchedule(){
		return ComplementedSchedule;
	}
	
	/**
	 * 완성된 시간표 List 를 반환한다.
	 * */
	private List<Schedule> getSchedule(){
		int chackCount1 = 0;
		
		ComplementedSchedule = new ArrayList<Schedule>();
		final int TOTALCASES = getTotalCases();
		for(int CaseIndex = 0; CaseIndex < TOTALCASES; CaseIndex++){
			Schedule newOne = new Schedule();
			for(int ListIndex=0;ListIndex<SortedCourseList.size();ListIndex++){
				if(!newOne.add(SortedCourseList.get(ListIndex).get(getCaseIndex(ListIndex, CaseIndex)))){
					chackCount1++;
					
					CaseIndex += (getNextListsSize(ListIndex)-1);
					break;
				}
			}
			
			if(newOne.getCourses().size() == SortedCourseList.size()){
				ComplementedSchedule.add(new Schedule(newOne));
			}
		}
		System.out.println("총 경우의 수: " + TOTALCASES);
		System.out.println("추가 안됨(" + chackCount1++ + ")");
		System.out.println("추가된 시간표: " + ComplementedSchedule.size());
		return ComplementedSchedule;
	}
	
	/**
	 * 공강시간 선택된 과목 제거
	 * */
	public void deleteCheackedCourse(List<Course> selectedCourseList,JCheckBox[][] chbox){
		for(int n=0; n < 5;n++){
			for(int m=1;m<10;m++){
				if(chbox[n][m].isSelected()){
					for(int index=0; index< selectedCourseList.size();index++){
						if(selectedCourseList.get(index).getSubjectTable()[n+1][m] != null){
							selectedCourseList.remove(index);
							index--;
						}
					}
				}
			}
		}
	}
	
	/**
	 * 과목별로 분류된 리스트의 크기를 반환한다.
	 * @param ListIndex 리스트 Index
	 * */
	public int getNextListsSize(int ListIndex){
		int DivCount = 1;
		
		for(int Index = ListIndex+1; Index < SortedCourseList.size(); Index++){
			DivCount *= SortedCourseList.get(Index).size();
		}
		
		return DivCount;
	}
	
	/**
	 * @param CaseIndex, 시간표의 index 값.
	 * */
	public int getCaseIndex(int ListIndex,int CaseIndex){
		return (CaseIndex/getNextListsSize(ListIndex))%SortedCourseList.get(ListIndex).size();
	}
	
	/**
	 * SortedCourseList 에 저장된 각각의 과목으로 만들수 있는 최대 시간표의 갯수를 반환
	 * 경우의 수를 반환한다.
	 * 
	 * @return TotalCases
	 * */
	public int getTotalCases(){
		int Result = 1;
		for(int Count = 0; Count < SortedCourseList.size(); Count++){
			Result *= SortedCourseList.get(Count).size();
		}
		return Result;
	}
	
	/**
	 * 과목별로 SortedCourseList 에 add한다.
	 * TODO 알고리즘 좀더 좋게 만들어보자...ㅠ
	 * */
	public void setSortToCourseName(){
		if(SelectedCourseList.size() != 0){
			ArrayList<Course> sameCourse = new ArrayList<Course>();
			sameCourse.add(SelectedCourseList.get(0));
			for(int Count=1; Count < SelectedCourseList.size(); Count++){
				// 이전 과목과 다를때
				if(!SelectedCourseList.get(Count-1).getName().equals(SelectedCourseList.get(Count).getName())){
					
					SortedCourseList.add(new ArrayList<Course>(sameCourse));
					sameCourse.clear();
				}
				
				sameCourse.add(SelectedCourseList.get(Count));
			}
			SortedCourseList.add(new ArrayList<Course>(sameCourse));
		}
	}
	
	
	/**
	 * 텍스트에서 가지고온 강좌의 String을 Course List로 반환한다.
	 * */
	public List<Course> getCourse(String courseData){
		List<Course> mCourseList = new ArrayList<Course>();
		try {
			
			String []line = courseData.split("\n");
			String []lineSection = null;
			//while((line = reader.readLine()) != null)
			for(int index = 1; index < line.length;index++){
				lineSection = line[index].split("\t");
				
				mCourseList.add(
						new Course("TEST", lineSection[0], lineSection[1], 
								lineSection[2], lineSection[3], lineSection[4], lineSection[5], 
								0, lineSection[6], 
								lineSection[7], lineSection[8], lineSection[9]));
			}
			System.out.println("성공 mCourseList.size() : " + mCourseList.size());
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}
		
		return mCourseList;
	}
	
	/**
	 * 리스트에 있는 String 을 정렬하여 반환
	 * @param PrintList 출력할 리스트
	 * @return 정렬된 문자열
	 * */
	public String PrintCourseList(List<Course> PrintList){
		String result = new String();
		
		for(int index=0; index < PrintList.size();index++){
			result += "index[" +index +"] ";
			result += "Category: " + PrintList.get(index).getCategory();
			result += "Number: " + PrintList.get(index).getNumber();
			result += "Group: " + PrintList.get(index).getGroup();
			result += "Name: " + PrintList.get(index).getName();
			result += "Level: " + PrintList.get(index).getLevel();
			result += "Credit: " + PrintList.get(index).getCredit();
			result += "Section: " + PrintList.get(index).getSection();
			result += "Preference: " + PrintList.get(index).getPreference();
			result += "SubjectTableTxt: " + PrintList.get(index).getSubjectTableTxt();
			//result += "SubjectTable: " + PrintList.get(index).getSubjectTable();
			result += "Propesser: " + PrintList.get(index).getPropesser();
			result += "Evaluation: " + PrintList.get(index).getEvaluation();
			result += "Note: " + PrintList.get(index).getNote() + "\n";
		}
		
		return result;
	}
	
	
	/**
	 * 과목별로 정렬된 이중리스트의 데이터를 정렬하여 반환
	 * @param PrintList 출력할 이중리스트
	 * @return 정렬된 문자열 
	 * */
	public String PrintDoubleCourseList(List<List<Course>> PrintList){
		String result = new String("Size: " +PrintList.size());
		
		for(int index=0; index < PrintList.size();index++){
			result += "index[" +index +"] ";
			result += "Name: " + PrintList.get(index).get(0).getName();
			result += "\n" + PrintCourseList(PrintList.get(index));
		}
		
		return result;
	}
	
	public void setSelectedCourseList(List<Course> SelectedCourse){
		this.SelectedCourseList = SelectedCourse;
	}
	public List<Course> getSelectedCourseList(){
		return SelectedCourseList;
	}
	public void setSortedCourseList(List<List<Course>> SortedCourseList){
		this.SortedCourseList = SortedCourseList;
	}
	public List<List<Course>> getSortedCourseList(){
		return SortedCourseList;
	}
}

%>


<%
	Main ma = new Main();
	List<Schedule> result = ma.getResult();

	for(int n= 0 ; n< result.size(); n++){
		out.println("완성된 시간표 _ " + n+"<br>");
		out.println(result.get(n).toString());
		out.println("<br><br>");
	}
%>



</body>
</html>