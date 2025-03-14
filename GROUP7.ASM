.model small
.stack 100h
.data
        menu db 10,"Shape Generator System",10
             db "1. Line",10
             db "2. Square",10
             db "3. Rectangle",10
             db "4. Triangle",10
             db "5. Parallel",10
             db "6. Trapezoid",10
             db "7. Diamond",10
             db "8. Hexagon",10
             db "9. Exit",10
             db "Enter your choice (1-9): $"
     invalid db 10,"Invalid Choice, Please Try Again. $"
.code
MAIN PROC
        mov ax, @data
        mov ds, ax
        display_menu:
                mov ax, @data 			; Load data address into accumulator register
		mov ds, ax			; Load ax into data segment
		mov ah, 09h			; String display function
		mov dx, offset menu
		int 21h				; open dos
		mov ah, 01h			; Input character function
		int 21h		
		sub al, 30h	
			
		cmp al, 1			; check whether the option match to 1
		je draw_line			; jump if equal 
                cmp al, 2
                je draw_square
                cmp al, 3
                je draw_rectangle
                cmp al, 4
                je draw_triangle
                cmp al, 5
                je draw_parallel
                cmp al, 6
                je draw_trapezoid
                cmp al, 7
                je draw_diamond
                cmp al, 8
                je draw_hexagon
                cmp al, 9
                je exit_program

                mov dx, offset invalid
                mov ah, 09h
                int 21h
                jmp display_menu
       draw_line:
                call line
                jmp display_menu
       draw_square:
                call square
                jmp display_menu
       draw_rectangle:
                call rectangle
                jmp display_menu
       draw_triangle:
                call triangle
                jmp display_menu
       draw_parallel:
                call parallel
                jmp display_menu
       draw_trapezoid:
                call trapezoid
                jmp display_menu
       draw_diamond:
                call diamond
                jmp display_menu
       draw_hexagon:
                call hexagon
                jmp display_menu
       exit_program:
                mov ah, 4ch		;close function
                int 21h			;close dos

line PROC
	mov ax, 13h			; BIOS video mode
	int 10h

	mov cx, 50 			; start x-coordinate
	mov dx, 50			; start y-coordinate
	mov bx, 250 			; end x-coordinate
	
        mov al, 14                      ; colour (yellow)
	horizontal_loop:
		mov ah ,0Ch
		int 10h
		inc cx			; increase cx
		cmp cx, bx		; check whether cx equal to bx
		jne horizontal_loop	; if not equal continue loop
	mov ah, 00h			; wait for key press
	int 16h	
	mov al, 0		
	mov ax, 03h			; exit 13h video mode, restore text mode
	int 10h
	ret
line ENDP

square PROC				; Square procedure start 
	mov ah, 0 
	mov al, 13h 			;8-bit register
	int 10h 

	mov cx, 50			; Set cx to 50 
	mov dx, 50			; Set dx to 50 
	mov bx, 150			; Set bx to 150 
	mov di, 150			; Set di to 150 

	mov al, 13			; Set pink color 
	square_loop:			; Start square loop 
		push cx			; Save current cx  
		horizontal_loop1:		; Start horizontal loop  
			mov ah, 0Ch		; Draw in graphics mode 
			int 10h 
			inc cx			; Increase cx  
			cmp cx, bx		; Check whether cx equal to bx  
			jne horizontal_loop1	; If not equal continue horizontal loop 
		pop cx				; Restore original cx value 
		inc dx				; Increase y-coordinate 
		cmp dx, di			; Compare dx and di 
		jne square_loop			; If not equal continue square loop 

	mov ah, 00h 
        int 16h			; Wait for key press

        mov ax, 03h		; Back to text mode
	int 10h 
	ret			; Return from square procedure 
square ENDP			; Square procedure end

rectangle PROC					; Start of rectangle procedure
	mov ah, 0				; Set video function (0 = set mode)
    	mov al, 13h               		; Set video mode 13h (320x200 graphics)
    	int 10h                   		; BIOS interrupt 10h - Changes video mode

    	mov cx, 50                		; Set X starting position to 50
    	mov dx, 50                		; Set Y starting position to 50
   	mov bx, 150               		; Set X ending position to 150 (width = 100)
    	mov di, 100              		; Set Y ending position to 100 (height = 50)
    
    	mov ax, 0C0h             		; Prepare for pixel writing
    	mov bh, 0                 		; Set page number to 0
    	mov al, 5                 		; Set color to 5 (magenta)

    	rectangle_loop:          		; Start of main rectangle drawing loop
        	push cx               		; Save current X position on stack
        	horizontal_loop2:  		; Start of horizontal line drawing loop
            		mov ah, 0Ch		; Set function to write pixel
            		int 10h			; BIOS interrupt 10h - Draw pixel at (CX,DX)
           	 	inc cx			; Move to next X position
            		cmp cx, bx		; Compare current X with end X
            		jne horizontal_loop2 	; If not equal, continue drawing line

        	pop cx               		; Restore initial X position for next line
        
        	inc dx                		; Move down one Y position
        	cmp dx, di           		; Compare current Y with end Y
        	jne rectangle_loop    		; If not equal, draw next line

    	mov ah, 00h              		; Prepare to wait for keypress
    	int 16h                  		; BIOS interrupt 16h - Wait for any key
    	mov ax, 03h              		; Prepare to return to text mode
   	int 10h                 	 	; BIOS interrupt 10h - Change back to text mode
    	ret                      		; Return from procedure
rectangle ENDP               			; End of rectangle procedure

triangle PROC
        mov ah, 0				; prepare to set mode
        mov al, 13h				; BIOS video mode
        int 10h

        mov cx, 50				; start x-coordinate
        mov bx, 150				; end x-coordinate
        mov dx, 100				; start y-coordinate
        mov di, 50				; end y-coordinatev(ending height of shape)

        mov al, 9				; set colour
        Fill_Triangle:
                push cx				; save value of cx
                push bx				; save value of bx
                horizontal_loop4:
                        mov ah, 0Ch
                        int 10h
                        inc cx			; increase cx
                        cmp cx, bx		; check if cx equals bx
                        jne horizontal_loop4	; if cx not equals bx jump back to loop

                pop bx				; restore value of bx
                pop cx				; restore value of cx

                inc cx				; incrase cx to next pixels
                dec bx				; decrease bx to next pixels

                dec dx				; decrease dx to next line
                cmp dx, di			; compare dx with di
                jne Fill_Triangle		; jump back if dx not equal di

        mov ah, 00h				; wait for key press	
        int 16h					; interrupt 16h

        mov ax, 03h				; text mode
        int 10h					
        ret					; return from triangle (draw_triangle in MAIN PROC)
triangle ENDP

parallel PROC
        mov ah, 0				;set video mode
        mov al, 13h				;video mode to 13h (320x200pixels, 256 colors)
        int 10h					;BIOS interrupt 10h
	
        mov cx, 50				;starting x-coordinate
        mov dx, 50				;starting y-coordinate
        mov bx, 150				;ending x-coordinate (each line)
        mov di, 100				;ending y-coordinate (height of shape)

        mov al, 3				;color for drawing (cyan)
        parallelloop:	
                push cx				;store current value
                push bx
                horizontal_loop3:
                        mov ah, 0Ch		;write pixel
                        int 10h		
                        inc cx			;increase cx to next pixel
                        cmp cx, bx		;compares cx with bx
                        jne horizontal_loop3	;if cx != bx jump backs to loop
                pop bx				;restores the original bx
                pop cx				;restores the original cx

                inc cx				;increse cx to next starting-x coordinate
                inc bx				;increse cx to next ending-x coordinate
               
                inc dx				;increaments the y-coordinate(dx) move to next line
                cmp dx, di			;compares current y-coordinate (dx) with maximum y-coordinate(di)
                jne parallelloop		;loop back again if dx != di
        
        mov ah,00h				;wait for a key press
        int 16h					;interrupt 16h

        mov ah, 0				;prepares to set video mode again
        mov al, 03h				;text mode
        int 10h					
        ret					;returns from parallel procedure (draw_parallel label in main procedure)
parallel ENDP

trapezoid PROC
        mov ax, 13h                             ; Set video mode
	int 10h					; Video services (handles screen/display functions)

	mov cx, 50             			; Left X starting position
	mov dx, 50            			; Y starting position (top)
	mov bx, 100          			; Right X ending position
	mov di, 100            			; Y ending position (bottom)
    
	mov al, 2              			; Color (2 = green)
	Fill_Trapezoid:
        	push cx          		; Save current left X position
        	push bx           		; Save current right X position

        	horizontal_loop5:
            		mov ah, 0Ch    		; Write pixel function
            		int 10h        		; Draw the pixel at current position (CX,DX)
            		inc cx       		; Move to next X position
            		cmp cx, bx     		; Check if reached right edge
            		jne horizontal_loop5

        	pop bx             				; Restore right X position
        	pop cx             				; Restore left X position

        	dec cx             				; Move left edge inward
        	inc bx            				; Move right edge outward
        
        	inc dx             				; Move down one row
        	cmp dx, di        				; Check if reached bottom
       	 	jne Fill_Trapezoid 				; Jump if Not Equal
    
    	mov ah, 00h           					; Prepare to wait for keypress
    	int 16h               					; Keyboard services (waits for key press)

   	mov ax, 03h           				; Return to text mode
    	int 10h              				; Changes back to text mode
    	ret                   				; Return from procedure 
trapezoid ENDP

diamond PROC
        mov ax, 13h					; set video mode to 13h
        int 10h						; BIOS interrupt

        mov cx, 50					; starting x-coordinate
        mov bx, 150					; ending x-coodinate
        mov dx, 100					; starting y-coordinate
        mov di, 50					; ending y-coordinate [height of shape]

        mov al, 9					; set colour
        Fill_Diamond:					
                push cx					; store value
                push bx
                horizontal_loop6:			
                        mov ah, 0Ch			; set pixels colour
                        int 10h				; write pixels
                        inc cx				; increase cx
                        cmp cx, bx			; compare cx with bx
                        jne horizontal_loop6		; jump back if cx not equals bx

                pop bx					; restore original value bx
                pop cx

                inc cx					; increase cx                 		
		dec bx					; decrease bx

                dec dx					; decrease dx move to new line
                cmp dx, di				; compare dx with di
                jne Fill_Diamond			; jump back if dx not equals di


        mov cx, 50					; resets starting x-coordinate
        mov bx, 150					; resets ending x-coodinate
        mov dx, 100					; resets starting y-coodinate
        mov di, 150					; resets ending y-coodinate
        Fill_Diamond2:
                push cx					; store value on the stack
                push bx
                horizontal_loop7:
                        mov ah, 0Ch
                        int 10h
                        inc cx				; increase cx to ending x-coordinate
                        cmp cx, bx			
                        jne horizontal_loop7

                pop bx					; restore original value
                pop cx

                inc cx					; increase cx to next pixels
                dec bx					; decrease bx to next pixels

                inc dx					; increase dx to di
                cmp dx, di
                jne Fill_Diamond2
        mov ah, 00h					; wait for key press
        int 16h						; interupt 16h

        mov ax, 03h					; text mode
        int 10h						
        ret 						; returns from diamond (draw_diamond label in MAIN PROC)              
diamond ENDP

hexagon PROC			; Hexagon procedure start		
        mov ax, 13h		; 16-bit register
        int 10h

	mov cx, 50		; Set cx to 50 
	mov dx, 50		; Set dx to 50 
        mov bx, 100             ; Set bx to 100
	mov di, 85		; Set di to 85 

        mov al, 7		; Set light gray color
        Fill_Hexagon:		; Start draw first half of the hexagon
                push cx			; Save current cx
                push bx			; Save current bx
                horizontal_loop8:		; Start horizontal loop8
                        mov ah, 0Ch		; Draw in graphics mode
                        int 10h
                        inc cx			; Increase cx  
			cmp cx, bx		; Check whether cx equal to bx  
			jne horizontal_loop8	; If not equal continue horizontal loop8             
               pop bx			; Restore original bx value
               pop cx			; Restore original cx value 

               dec cx			; Decrease cx
               inc bx			; Increase bx

               inc dx			; Increase dx
               cmp dx, di		; Check whether dx equal to di
               jne Fill_Hexagon		; If not equal continue Fill_Hexagon 

        mov cx, 15		; Set cx to 15
        mov dx, 85		; Set dx to 85
        mov bx, 135		; Set bx to 135
        mov di, 120		; Set di to 120

        Fill_Hexagon2:		; Start draw second half of the hexagon
                push cx			; Save current cx
                push bx			; Save current bx
                horizontal_loop9:	; Start horizontal loop9	
                        mov ah, 0Ch		; Draw in graphics mode
                        int 10h
                        inc cx			; Increase cx  
			cmp cx, bx		; Check whether cx equal to bx  
                        jne horizontal_loop9    ; If not equal continue horizontal loop9
               
               pop bx			; Restore original bx value
               pop cx			; Restore original cx value 

               inc cx			; Increase cx
               dec bx			; Decrease bx

               inc dx			; Increase dx
               cmp dx, di		; Check whether dx equal to di
               jne Fill_Hexagon2        ; If not equal continue Fill_Hexagon2 

        mov ah, 00h
        int 16h			; Wait for key press

        mov ax, 03h		; Back to text mode
        int 10h
	ret			; Return from hexagon procedure 
hexagon ENDP			; Hexagon procedure end

MAIN ENDP
END MAIN

