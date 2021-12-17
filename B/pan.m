#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM never_0 */
	case 3: // STATE 1 - barber1.pml.nvr:5 - [(!((Customer[1]._p==attended)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		if (!( !((((int)((P1 *)Pptr(BASE+1))->_p)==19))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 8 - barber1.pml.nvr:10 - [(!((Customer[1]._p==attended)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][8] = 1;
		if (!( !((((int)((P1 *)Pptr(BASE+1))->_p)==19))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 13 - barber1.pml.nvr:12 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][13] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Customer */
	case 6: // STATE 1 - barber1.pml:30 - [(mutex)] (25:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!(((int)now.mutex)))
			continue;
		/* merge: mutex = 0(0, 2, 25) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex);
		now.mutex = 0;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 7: // STATE 5 - barber1.pml:57 - [((freeseats>0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		if (!((((int)now.freeseats)>0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 6 - barber1.pml:58 - [freeseats = (freeseats-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.freeseats);
		now.freeseats = (((int)now.freeseats)-1);
#ifdef VAR_RANGES
		logval("freeseats", ((int)now.freeseats));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 7 - barber1.pml:59 - [shaved[_pid] = unattended] (0:0:1 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		(trpt+1)->bup.oval = now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ];
		now.shaved[ Index(((P1 *)_this)->_pid, 5) ] = 1;
#ifdef VAR_RANGES
		logval("shaved[_pid]", now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 8 - barber1.pml:60 - [queue[end] = _pid] (0:0:1 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = ((int)now.queue[ Index(((int)now.end), 8) ]);
		now.queue[ Index(now.end, 8) ] = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("queue[end]", ((int)now.queue[ Index(((int)now.end), 8) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 9 - barber1.pml:61 - [end = ((end+1)%8)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((int)now.end);
		now.end = ((((int)now.end)+1)%8);
#ifdef VAR_RANGES
		logval("end", ((int)now.end));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 10 - barber1.pml:62 - [printf('%d Waiting room\\n',_pid)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		Printf("%d Waiting room\n", ((int)((P1 *)_this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 11 - barber1.pml:25 - [customers = (customers+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = ((int)now.customers);
		now.customers = (((int)now.customers)+1);
#ifdef VAR_RANGES
		logval("customers", ((int)now.customers));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 13 - barber1.pml:35 - [mutex = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][13] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex);
		now.mutex = 1;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 15 - barber1.pml:30 - [(ready)] (19:0:1 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (!(((int)now.ready)))
			continue;
		/* merge: ready = 0(0, 16, 19) */
		reached[1][16] = 1;
		(trpt+1)->bup.oval = ((int)now.ready);
		now.ready = 0;
#ifdef VAR_RANGES
		logval("ready", ((int)now.ready));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 16: // STATE 19 - barber1.pml:66 - [((shaved[_pid]==done))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][19] = 1;
		if (!((now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]==2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 20 - barber1.pml:68 - [((freeseats==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][20] = 1;
		if (!((((int)now.freeseats)==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 21 - barber1.pml:69 - [printf('%d Skipped, no room\\n',_pid)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][21] = 1;
		Printf("%d Skipped, no room\n", ((int)((P1 *)_this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 22 - barber1.pml:35 - [mutex = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][22] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex);
		now.mutex = 1;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 30 - barber1.pml:74 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][30] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Barber */
	case 21: // STATE 2 - barber1.pml:20 - [((customers>0))] (9:0:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((int)now.customers)>0)))
			continue;
		/* merge: customers = (customers-1)(0, 3, 9) */
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.customers);
		now.customers = (((int)now.customers)-1);
#ifdef VAR_RANGES
		logval("customers", ((int)now.customers));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 22: // STATE 6 - barber1.pml:30 - [(mutex)] (10:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		if (!(((int)now.mutex)))
			continue;
		/* merge: mutex = 0(0, 7, 10) */
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex);
		now.mutex = 0;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 23: // STATE 10 - barber1.pml:43 - [freeseats = (freeseats+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		(trpt+1)->bup.oval = ((int)now.freeseats);
		now.freeseats = (((int)now.freeseats)+1);
#ifdef VAR_RANGES
		logval("freeseats", ((int)now.freeseats));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 11 - barber1.pml:44 - [sitting = queue[start]] (0:0:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.sitting);
		now.sitting = ((int)now.queue[ Index(((int)now.start), 8) ]);
#ifdef VAR_RANGES
		logval("sitting", ((int)now.sitting));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 12 - barber1.pml:45 - [shaved[sitting] = done] (0:0:1 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.oval = now.shaved[ Index(((int)now.sitting), 5) ];
		now.shaved[ Index(now.sitting, 5) ] = 2;
#ifdef VAR_RANGES
		logval("shaved[sitting]", now.shaved[ Index(((int)now.sitting), 5) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 26: // STATE 13 - barber1.pml:46 - [start = ((start+1)%8)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		(trpt+1)->bup.oval = ((int)now.start);
		now.start = ((((int)now.start)+1)%8);
#ifdef VAR_RANGES
		logval("start", ((int)now.start));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 14 - barber1.pml:47 - [printf('Barber shaved %d\\n',sitting)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		Printf("Barber shaved %d\n", ((int)now.sitting));
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 15 - barber1.pml:35 - [ready = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		(trpt+1)->bup.oval = ((int)now.ready);
		now.ready = 1;
#ifdef VAR_RANGES
		logval("ready", ((int)now.ready));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 17 - barber1.pml:35 - [mutex = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][17] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex);
		now.mutex = 1;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 30: // STATE 22 - barber1.pml:51 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][22] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

