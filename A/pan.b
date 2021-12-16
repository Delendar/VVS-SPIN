	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Customer */
;
		;
		
	case 4: // STATE 2
		;
		now.shaved[ Index(((P1 *)_this)->_pid, 5) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 6: // STATE 4
		;
		now.sitting = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 9: // STATE 7
		;
		now.queue[ Index(now.end, 1) ] = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 8
		;
		now.end = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 9
		;
		now.customers = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		;
		;
		
	case 15: // STATE 19
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Barber */
;
		;
		;
		;
		
	case 18: // STATE 3
		;
		now.shaved[ Index(now.sitting, 5) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 20: // STATE 5
		;
		now.sitting = trpt->bup.oval;
		;
		goto R999;

	case 21: // STATE 6
		;
		now.start = trpt->bup.oval;
		;
		goto R999;

	case 22: // STATE 7
		;
		now.customers = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 24: // STATE 9
		;
		now.sitting = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 26: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;
	}

