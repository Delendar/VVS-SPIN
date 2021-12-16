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
	case 3: // STATE 1 - exercise_a.pml.nvr:5 - [(((Barber._p==sleeping)&&(Customer._p==leftUnattended)))] (6:0:0 - 1)
		
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
		if (!(((((int)((P0 *)Pptr(f_pid(0)))->_p)==10)&&(((int)((P1 *)Pptr(f_pid(1)))->_p)==12))))
			continue;
		/* merge: assert(!(((Barber._p==sleeping)&&(Customer._p==leftUnattended))))(0, 2, 6) */
		reached[2][2] = 1;
		spin_assert( !(((((int)((P0 *)Pptr(f_pid(0)))->_p)==10)&&(((int)((P1 *)Pptr(f_pid(1)))->_p)==12))), " !(((Barber._p==sleeping)&&(Customer._p==leftUnattended)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[2][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - exercise_a.pml.nvr:10 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Customer */
	case 5: // STATE 1 - exercise_a.pml:32 - [printf('%d arrives\\n',_pid)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		Printf("%d arrives\n", ((int)((P1 *)_this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 2 - exercise_a.pml:33 - [shaved[_pid] = unattended] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ];
		now.shaved[ Index(((P1 *)_this)->_pid, 5) ] = 1;
#ifdef VAR_RANGES
		logval("shaved[_pid]", now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - exercise_a.pml:36 - [((sitting==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!((((int)now.sitting)==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - exercise_a.pml:36 - [sitting = _pid] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = ((int)now.sitting);
		now.sitting = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("sitting", ((int)now.sitting));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - exercise_a.pml:37 - [((shaved[_pid]==done))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		if (!((now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]==2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 6 - exercise_a.pml:40 - [(((sitting!=0)&&(customers<2)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!(((((int)now.sitting)!=0)&&(((int)now.customers)<2))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 7 - exercise_a.pml:41 - [queue[end] = _pid] (0:0:1 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		(trpt+1)->bup.oval = ((int)now.queue[ Index(((int)now.end), 2) ]);
		now.queue[ Index(now.end, 2) ] = ((int)((P1 *)_this)->_pid);
#ifdef VAR_RANGES
		logval("queue[end]", ((int)now.queue[ Index(((int)now.end), 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 8 - exercise_a.pml:42 - [end = ((end+1)%2)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = ((int)now.end);
		now.end = ((((int)now.end)+1)%2);
#ifdef VAR_RANGES
		logval("end", ((int)now.end));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 9 - exercise_a.pml:43 - [customers = (customers+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((int)now.customers);
		now.customers = (((int)now.customers)+1);
#ifdef VAR_RANGES
		logval("customers", ((int)now.customers));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 10 - exercise_a.pml:44 - [((shaved[_pid]==done))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		if (!((now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]==2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 11 - exercise_a.pml:45 - [(((sitting!=0)&&(customers==2)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (!(((((int)now.sitting)!=0)&&(((int)now.customers)==2))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 15 - exercise_a.pml:48 - [printf('%d left %e\\n',_pid,shaved[_pid])] (0:0:0 - 4)
		IfNotBlocked
		reached[1][15] = 1;
		Printf("%d left %e\n", ((int)((P1 *)_this)->_pid), now.shaved[ Index(((int)((P1 *)_this)->_pid), 5) ]);
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 19 - exercise_a.pml:50 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][19] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Barber */
	case 18: // STATE 1 - exercise_a.pml:16 - [((sitting!=0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)now.sitting)!=0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 2 - exercise_a.pml:17 - [printf('%d is being shaved\\n',sitting)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		Printf("%d is being shaved\n", ((int)now.sitting));
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 3 - exercise_a.pml:18 - [shaved[sitting] = done] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = now.shaved[ Index(((int)now.sitting), 5) ];
		now.shaved[ Index(now.sitting, 5) ] = 2;
#ifdef VAR_RANGES
		logval("shaved[sitting]", now.shaved[ Index(((int)now.sitting), 5) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 4 - exercise_a.pml:20 - [((customers>0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!((((int)now.customers)>0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 5 - exercise_a.pml:20 - [sitting = queue[start]] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.sitting);
		now.sitting = ((int)now.queue[ Index(((int)now.start), 2) ]);
#ifdef VAR_RANGES
		logval("sitting", ((int)now.sitting));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 6 - exercise_a.pml:21 - [start = ((start+1)%2)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.start);
		now.start = ((((int)now.start)+1)%2);
#ifdef VAR_RANGES
		logval("start", ((int)now.start));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 7 - exercise_a.pml:22 - [customers = (customers-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)now.customers);
		now.customers = (((int)now.customers)-1);
#ifdef VAR_RANGES
		logval("customers", ((int)now.customers));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 8 - exercise_a.pml:24 - [((customers==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		if (!((((int)now.customers)==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 26: // STATE 9 - exercise_a.pml:24 - [sitting = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		(trpt+1)->bup.oval = ((int)now.sitting);
		now.sitting = 0;
#ifdef VAR_RANGES
		logval("sitting", ((int)now.sitting));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 10 - exercise_a.pml:25 - [printf('Barber sleeping\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		Printf("Barber sleeping\n");
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 16 - exercise_a.pml:28 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][16] = 1;
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

