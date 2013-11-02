/***********************************************************************
**
**  REBOL [R3] Language Interpreter and Run-time Environment
**  Copyright 2012 REBOL Technologies
**  REBOL is a trademark of REBOL Technologies
**  Licensed under the Apache License, Version 2.0
**  This is a code-generated file.
**
************************************************************************
**
**  Title: Boot Definitions
**  Build: A0
**  Date:  2-Nov-2013
**  File:  bootdefs.h
**
**  AUTO-GENERATED FILE - Do not modify. (From: make-boot.r)
**
***********************************************************************/


#define REBOL_VER 2
#define REBOL_REV 101
#define REBOL_UPD 0
#define REBOL_SYS 2
#define REBOL_VAR 5

/***********************************************************************
**
**	REBOL Boot Strings
**
**		These are special strings required during boot and other
**		operations. Putting them here hides them from exe hackers.
**		These are all string offsets within a single string.
**
***********************************************************************/
#define RS_SCAN				0
#define RS_INFO				31
#define RS_TRACE			32
#define RS_STACK			43
#define RS_DUMP				45
#define RS_ERROR			59
#define RS_ERRS				72
#define RS_WATCH			76
#define RS_EXTENSION		79
#define RS_MAX	82
#define RS_SIZE	1294

/***********************************************************************
**
*/	enum REBOL_Symbols
/*
**		REBOL static canonical words (symbols) used with the code.
**
***********************************************************************/
{
	SYM_NOT_USED = 0,
    SYM_END_TYPE,			// 1
    SYM_UNSET_TYPE,			// 2
    SYM_NONE_TYPE,			// 3
    SYM_LOGIC_TYPE,			// 4
    SYM_INTEGER_TYPE,		// 5
    SYM_DECIMAL_TYPE,		// 6
    SYM_PERCENT_TYPE,		// 7
    SYM_MONEY_TYPE,			// 8
    SYM_CHAR_TYPE,			// 9
    SYM_PAIR_TYPE,			// 10
    SYM_TUPLE_TYPE,			// 11
    SYM_TIME_TYPE,			// 12
    SYM_DATE_TYPE,			// 13
    SYM_BINARY_TYPE,		// 14
    SYM_STRING_TYPE,		// 15
    SYM_FILE_TYPE,			// 16
    SYM_EMAIL_TYPE,			// 17
    SYM_URL_TYPE,			// 18
    SYM_TAG_TYPE,			// 19
    SYM_BITSET_TYPE,		// 20
    SYM_IMAGE_TYPE,			// 21
    SYM_VECTOR_TYPE,		// 22
    SYM_BLOCK_TYPE,			// 23
    SYM_PAREN_TYPE,			// 24
    SYM_PATH_TYPE,			// 25
    SYM_SET_PATH_TYPE,		// 26
    SYM_GET_PATH_TYPE,		// 27
    SYM_LIT_PATH_TYPE,		// 28
    SYM_MAP_TYPE,			// 29
    SYM_DATATYPE_TYPE,		// 30
    SYM_TYPESET_TYPE,		// 31
    SYM_WORD_TYPE,			// 32
    SYM_SET_WORD_TYPE,		// 33
    SYM_GET_WORD_TYPE,		// 34
    SYM_LIT_WORD_TYPE,		// 35
    SYM_REFINEMENT_TYPE,	// 36
    SYM_ISSUE_TYPE,			// 37
    SYM_NATIVE_TYPE,		// 38
    SYM_ACTION_TYPE,		// 39
    SYM_REBCODE_TYPE,		// 40
    SYM_COMMAND_TYPE,		// 41
    SYM_OP_TYPE,			// 42
    SYM_CLOSURE_TYPE,		// 43
    SYM_FUNCTION_TYPE,		// 44
    SYM_FRAME_TYPE,			// 45
    SYM_OBJECT_TYPE,		// 46
    SYM_MODULE_TYPE,		// 47
    SYM_ERROR_TYPE,			// 48
    SYM_TASK_TYPE,			// 49
    SYM_PORT_TYPE,			// 50
    SYM_GOB_TYPE,			// 51
    SYM_EVENT_TYPE,			// 52
    SYM_HANDLE_TYPE,		// 53
    SYM_STRUCT_TYPE,		// 54
    SYM_LIBRARY_TYPE,		// 55
    SYM_UTYPE_TYPE,			// 56
    SYM_ANY_TYPEX,			// 57 - any-type!
    SYM_ANY_WORDX,			// 58 - any-word!
    SYM_ANY_PATHX,			// 59 - any-path!
    SYM_ANY_FUNCTIONX,		// 60 - any-function!
    SYM_NUMBERX,			// 61 - number!
    SYM_SCALARX,			// 62 - scalar!
    SYM_SERIESX,			// 63 - series!
    SYM_ANY_STRINGX,		// 64 - any-string!
    SYM_ANY_OBJECTX,		// 65 - any-object!
    SYM_ANY_BLOCKX,			// 66 - any-block!
    SYM_DATATYPES,			// 67 - datatypes
    SYM_NATIVE,				// 68 - native
    SYM_SELF,				// 69 - self
    SYM_NONE,				// 70 - none
    SYM_TRUE,				// 71 - true
    SYM_FALSE,				// 72 - false
    SYM_ON,					// 73 - on
    SYM_OFF,				// 74 - off
    SYM_YES,				// 75 - yes
    SYM_NO,					// 76 - no
    SYM_PI,					// 77 - pi
    SYM_REBOL,				// 78 - rebol
    SYM_SYSTEM,				// 79 - system
    SYM_BASE,				// 80 - base
    SYM_SYS,				// 81 - sys
    SYM_MODS,				// 82 - mods
    SYM_SPEC,				// 83 - spec
    SYM_BODY,				// 84 - body
    SYM_WORDS,				// 85 - words
    SYM_VALUES,				// 86 - values
    SYM_TYPES,				// 87 - types
    SYM_TITLE,				// 88 - title
    SYM_X,					// 89 - x
    SYM_Y,					// 90 - y
    SYM__ADD,				// 91 - +
    SYM__,					// 92 - -
    SYM__P,					// 93 - *
    SYM_UNSIGNED,			// 94 - unsigned
    SYM__UNNAMED_,			// 95 - -unnamed-
    SYM__APPLY_,			// 96 - -apply-
    SYM_CODE,				// 97 - code
    SYM_DELECT,				// 98 - delect
    SYM_SECURE,				// 99 - secure
    SYM_PROTECT,			// 100 - protect
    SYM_NET,				// 101 - net
    SYM_CALL,				// 102 - call
    SYM_ENVR,				// 103 - envr
    SYM_EVAL,				// 104 - eval
    SYM_MEMORY,				// 105 - memory
    SYM_DEBUG,				// 106 - debug
    SYM_BROWSE,				// 107 - browse
    SYM_EXTENSION,			// 108 - extension
    SYM_HOUR,				// 109 - hour
    SYM_MINUTE,				// 110 - minute
    SYM_SECOND,				// 111 - second
    SYM_YEAR,				// 112 - year
    SYM_MONTH,				// 113 - month
    SYM_DAY,				// 114 - day
    SYM_TIME,				// 115 - time
    SYM_DATE,				// 116 - date
    SYM_WEEKDAY,			// 117 - weekday
    SYM_JULIAN,				// 118 - julian
    SYM_YEARDAY,			// 119 - yearday
    SYM_ZONE,				// 120 - zone
    SYM_UTC,				// 121 - utc
    SYM_PARSE,				// 122 - parse
    SYM_OR_BAR,				// 123 - |
    SYM_SET,				// 124 - set
    SYM_COPY,				// 125 - copy
    SYM_SOME,				// 126 - some
    SYM_ANY,				// 127 - any
    SYM_OPT,				// 128 - opt
    SYM_NOT,				// 129 - not
    SYM_AND,				// 130 - and
    SYM_THEN,				// 131 - then
    SYM_REMOVE,				// 132 - remove
    SYM_INSERT,				// 133 - insert
    SYM_CHANGE,				// 134 - change
    SYM_IF,					// 135 - if
    SYM_FAIL,				// 136 - fail
    SYM_REJECT,				// 137 - reject
    SYM_WHILE,				// 138 - while
    SYM_RETURN,				// 139 - return
    SYM_LIMIT,				// 140 - limit
    SYM_QQ,					// 141 - ??
    SYM_ACCEPT,				// 142 - accept
    SYM_BREAK,				// 143 - break
    SYM_SKIP,				// 144 - skip
    SYM_TO,					// 145 - to
    SYM_THRU,				// 146 - thru
    SYM_QUOTE,				// 147 - quote
    SYM_DO,					// 148 - do
    SYM_INTO,				// 149 - into
    SYM_ONLY,				// 150 - only
    SYM_END,				// 151 - end
    SYM_TYPE,				// 152 - type
    SYM_KEY,				// 153 - key
    SYM_PORT,				// 154 - port
    SYM_MODE,				// 155 - mode
    SYM_WINDOW,				// 156 - window
    SYM_DOUBLE,				// 157 - double
    SYM_CONTROL,			// 158 - control
    SYM_SHIFT,				// 159 - shift
    SYM_SHA1,				// 160 - sha1
    SYM_MD4,				// 161 - md4
    SYM_MD5,				// 162 - md5
    SYM_CRC32,				// 163 - crc32
    SYM_IDENTIFY,			// 164 - identify
    SYM_DECODE,				// 165 - decode
    SYM_ENCODE,				// 166 - encode
    SYM_CONSOLE,			// 167 - console
    SYM_FILE,				// 168 - file
    SYM_DIR,				// 169 - dir
    SYM_EVENT,				// 170 - event
    SYM_CALLBACK,			// 171 - callback
    SYM_DNS,				// 172 - dns
    SYM_TCP,				// 173 - tcp
    SYM_UDP,				// 174 - udp
    SYM_CLIPBOARD,			// 175 - clipboard
    SYM_GOB,				// 176 - gob
    SYM_OFFSET,				// 177 - offset
    SYM_SIZE,				// 178 - size
    SYM_PANE,				// 179 - pane
    SYM_PARENT,				// 180 - parent
    SYM_IMAGE,				// 181 - image
    SYM_DRAW,				// 182 - draw
    SYM_TEXT,				// 183 - text
    SYM_EFFECT,				// 184 - effect
    SYM_COLOR,				// 185 - color
    SYM_FLAGS,				// 186 - flags
    SYM_RGB,				// 187 - rgb
    SYM_ALPHA,				// 188 - alpha
    SYM_DATA,				// 189 - data
    SYM_RESIZE,				// 190 - resize
    SYM_NO_TITLE,			// 191 - no-title
    SYM_NO_BORDER,			// 192 - no-border
    SYM_DROPABLE,			// 193 - dropable
    SYM_TRANSPARENT,		// 194 - transparent
    SYM_POPUP,				// 195 - popup
    SYM_MODAL,				// 196 - modal
    SYM_ON_TOP,				// 197 - on-top
    SYM_HIDDEN,				// 198 - hidden
    SYM_OWNER,				// 199 - owner
    SYM_OWNER_READ,			// 200 - owner-read
    SYM_OWNER_WRITE,		// 201 - owner-write
    SYM_OWNER_EXECUTE,		// 202 - owner-execute
    SYM_GROUP_READ,			// 203 - group-read
    SYM_GROUP_WRITE,		// 204 - group-write
    SYM_GROUP_EXECUTE,		// 205 - group-execute
    SYM_WORLD_READ,			// 206 - world-read
    SYM_WORLD_WRITE,		// 207 - world-write
    SYM_WORLD_EXECUTE,		// 208 - world-execute
    SYM_BITS,				// 209 - bits
    SYM_CRASH,				// 210 - crash
    SYM_CRASH_DUMP,			// 211 - crash-dump
    SYM_WATCH_RECYCLE,		// 212 - watch-recycle
    SYM_WATCH_OBJ_COPY,		// 213 - watch-obj-copy
    SYM_STACK_SIZE			// 214 - stack-size
};

/***********************************************************************
**
*/	enum REBOL_Actions
/*
**		REBOL datatype action numbers.
**
***********************************************************************/
{
    A_TYPE = 0,				// Handled by interpreter
    A_ADD,					// 1
    A_SUBTRACT,				// 2
    A_MULTIPLY,				// 3
    A_DIVIDE,				// 4
    A_REMAINDER,			// 5
    A_POWER,				// 6
    A_AND,					// 7
    A_OR,					// 8
    A_XOR,					// 9
    A_NEGATE,				// 10
    A_COMPLEMENT,			// 11
    A_ABSOLUTE,				// 12
    A_ROUND,				// 13
    A_RANDOM,				// 14
    A_ODDQ,					// 15
    A_EVENQ,				// 16
    A_HEAD,					// 17
    A_TAIL,					// 18
    A_HEADQ,				// 19
    A_TAILQ,				// 20
    A_PASTQ,				// 21
    A_NEXT,					// 22
    A_BACK,					// 23
    A_SKIP,					// 24
    A_AT,					// 25
    A_INDEXQ,				// 26
    A_LENGTHQ,				// 27
    A_PICK,					// 28
    A_FIND,					// 29
    A_SELECT,				// 30
    A_REFLECT,				// 31
    A_MAKE,					// 32
    A_TO,					// 33
    A_COPY,					// 34
    A_TAKE,					// 35
    A_INSERT,				// 36
    A_APPEND,				// 37
    A_REMOVE,				// 38
    A_CHANGE,				// 39
    A_POKE,					// 40
    A_CLEAR,				// 41
    A_TRIM,					// 42
    A_SWAP,					// 43
    A_REVERSE,				// 44
    A_SORT,					// 45
    A_CREATE,				// 46
    A_DELETE,				// 47
    A_OPEN,					// 48
    A_CLOSE,				// 49
    A_READ,					// 50
    A_WRITE,				// 51
    A_OPENQ,				// 52
    A_QUERY,				// 53
    A_MODIFY,				// 54
    A_UPDATE,				// 55
    A_RENAME,				// 56
	A_MAX_ACTION
};

#define IS_BINARY_ACT(a) ((a) <= A_XOR)
