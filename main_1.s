   AREA |.text|, CODE, READONLY

nzer_asm	PROC	            ; Начало функции array_sum_asm
	EXPORT nzer_asm
        MOV R4, #0              ; Обнуление индекса элемента
        MOV R5, #0              ; Регистр для записи результата
nzer_Lab
        CMP R4, R1              ; Проверка на выход за пределы массива
        BXEQ  LR                ; Возврат из подпрограммы
        
        LDRB R6, [R0, R4]       ; Запись элемента в регистр
        
        ADD R4, R7              ; Увеличение индекса
        
        CMP R6, #0              ; Сравнение с 0
        ADDEQ R5, #1            ; Счёт нулей
        
        B nzer_Lab              ; Переход к следующему элементу
        
        ENDP

sneg_asm	PROC	            ; Начало функции array_sum_asm
	EXPORT sneg_asm
        MOV R4, #0              ; Обнуление индекса элемента
        MOV R5, #0              ; Регистр для записи результата
sneg_Lab
        CMP R4, R1              ; Проверка на выход за пределы массива
        BXEQ  LR                ; Возврат из подпрограммы
        
        LDRB R6, [R0, R4]       ; Запись элемента в регистр
        
        ADD R4, R7              ; Увеличение индекса
        
        SXTB R6,R6              ; Заполнение знака
        CMP R6, #0              ; Определение знака
        ADDLT R5, R6            ; Сложение отрицательных
        
        B sneg_Lab              ; Переход к следующему элементу
        
        ENDP

mpos_asm	PROC	            ; Начало функции array_sum_asm
	EXPORT mpos_asm
        MOV R4, #0              ; Обнуление индекса элемента
        MOV R5, #1              ; Регистр для записи результата
mpos_Lab
        CMP R4, R1              ; Проверка на выход за пределы массива
        BXEQ  LR                ; �'озврат из подпрограммы
        
        LDRB R6, [R0, R4]        ; �-апись элемента в регистр
        
        ADD R4, R7              ; Увеличение индекса
        
        SXTB R6,R6              ; �-аполнение знака
        CMP R6, #0              ; Определение знака
        MULGT R5, R6            ; Перемножение положительных

        B mpos_Lab              ; Переход к следующему элементу
        
        ENDP

array_calc_asm	PROC	; Начало функции array_treatment_asm
	EXPORT array_calc_asm
        
        MOV R7, #4
        MUL R1, R7
        
        PUSH {LR}
 
        BL nzer_asm             ; Кол-во  нулей
        STR R5, [R2, #0]       ; Запись результата в переменную

        BL sneg_asm             ; Сумма отрицательных
        STR R5, [R2, #4]       ; Запись результата в переменную

        BL mpos_asm             ; Произведение положительных
        STR R5, [R2, #8]       ; Запись результата в переменную
        
        POP {LR}
        BX LR
        
        ENDP

	END		; Конец файла