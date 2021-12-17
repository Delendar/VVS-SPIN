	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM never_0 */
;
		;
		;
		;
		
	case 5: // STATE 13
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Customer */

	case 6: // STATE 2
		;
		now.mutex = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 8: // STATE 6
		;
		now.freeseats = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 7
		;
		now.shaved[ Index(((P1 *)_this)->_pid, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 8
		;
		now.queue[ Index(now.end, 8) ] = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 9
		;
		now.end = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 13: // STATE 11
		;
		now.customers = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 13
		;
		now.mutex = trpt->bup.oval;
		;
		goto R999;

	case 15: // STATE 16
		;
		now.ready = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		;
		;
		
	case 19: // STATE 22
		;
		now.mutex = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 30
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Barber */

	case 21: // STATE 3
		;
		now.customers = trpt->bup.oval;
		;
		goto R999;

	case 22: // STATE 7
		;
		now.mutex = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 10
		;
		now.freeseats = trpt->bup.oval;
		;
		goto R999;

	case 24: // STATE 11
		;
		now.sitting = trpt->bup.oval;
		;
		goto R999;

	case 25: // STATE 12
		;
		now.shaved[ Index(now.sitting, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 26: // STATE 13
		;
		now.start = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 28: // STATE 15
		;
		now.ready = trpt->bup.oval;
		;
		goto R999;

	case 29: // STATE 17
		;
		now.mutex = trpt->bup.oval;
		;
		goto R999;

	case 30: // STATE 22
		;
		p_restor(II);
		;
		;
		goto R999;
	}

