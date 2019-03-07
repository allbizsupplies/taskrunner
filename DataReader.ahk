#include LegacyAHK.ahk


class DataReader {


	__new(inputFile) {
		; Initialise the data row index pointer as zero
		; so that first NextRow() call increments index to 1
		this.activeIndex := 0

		; Load data from CSV
		this.data := this.loadCSV(inputFile)
	}


	; Reads CSV row data into object properties
	loadCSV(inputFile)	{
		fieldNames := []
		rows := []

		Loop, Read, %inputFile%
		{
			; Read the first line as headers then the rest as data.
			if (A_Index = 1)
			{
				; Read the line as headers.
				Loop, Parse, A_LoopReadLine, %A_TAB%
				{
					fieldName := AHK.lowercase(A_LoopField)

					; Replace spaces with underscore.
					StringReplace, fieldName, fieldName, %A_SPACE%, _, All

					; Remove periods.
					StringReplace, fieldName, fieldName, ., , All 

					; Remove parentheses.
					StringReplace, fieldName, fieldName, (, , All
					StringReplace, fieldName, fieldName, ), , All

					; save the field name
					fieldNames.push(fieldName)
				}
			}
			else
			{
				; Save the row data.
				row := []
				Loop, Parse, A_LoopReadLine, %A_TAB%
				{
					; Get the header name for this field.
					fieldName := fieldNames[A_Index]

					; Save the data value.
					row[fieldName] := A_LoopField
				}

				rows.push(row)
			}
		}

		return rows
	}
}
