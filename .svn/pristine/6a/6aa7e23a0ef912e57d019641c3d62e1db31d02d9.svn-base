SELECT * FROM EN_ATACH_FILE;

SELECT ifnull(MAX(SEQ_NO),0) LAST_SEQ_NO
			  FROM EN_BOARD;
        
SELECT * FROM EN_BOARD;


SELECT QUIZ2.*
  FROM (SELECT ROWNUM RM, QUIZ.*
          FROM (SELECT * 
                  FROM EN_BOARD
                 WHERE CODE_NO = 102
              ORDER BY SEQ_NO DESC 
               ) QUIZ
        ) QUIZ2;

  
  
  SELECT *
    FROM EN_BOARD
    WHERE CODE_NO = 102
    ORDER BY DBMS_RANDOM.RANDOM;
    
SELECT QUIZ.*, RANK() OVER(ORDER BY QUIZ.BOARD_HIT DESC) RK
FROM 
    (SELECT *
      FROM EN_BOARD
      WHERE CODE_NO = 102
      ORDER BY DBMS_RANDOM.RANDOM
    ) QUIZ;
    
SELECT QUIZ2.*
FROM (
      SELECT QUIZ.*, RANK() OVER(ORDER BY QUIZ.SEQ_NO DESC) RK
      FROM 
          (SELECT *
            FROM EN_BOARD
            WHERE CODE_NO = 102
            ORDER BY DBMS_RANDOM.RANDOM
          ) QUIZ
      ) QUIZ2
    
WHERE QUIZ2.RK < 5;


SELECT QUIZ.* 
    FROM  (SELECT BOARD.*, ROWNUM RM 
              FROM EN_BOARD BOARD
             WHERE CODE_NO = 102
             ORDER BY DBMS_RANDOM.RANDOM 
          ) QUIZ
    WHERE QUIZ.RM <5;
    
    
    
SELECT QUIZ.* 
	      FROM  (SELECT BOARD.*, ROWNUM RM 
	               FROM EN_BOARD BOARD
	          where
		  			CODE_NO = 102 OR CODE_NO = 103
		
	           ORDER BY DBMS_RANDOM.RANDOM 
	          ) QUIZ
	  where
	    	QUIZ.RM <= 28;
       
INSERT INTO EN_LIKE
						(
							BOARD_LIKE
						,	BOARD_DISLIKE
						,	CODE_NO
						,	SOURCE_SEQ_NO
						)
				VALUES
						(
							0
						,	0
						,	103
						,	49
						);
            commit;
