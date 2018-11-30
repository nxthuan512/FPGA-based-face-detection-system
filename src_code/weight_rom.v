module	weight_rom	(
						//Input
						input						iClk,
						input			[9:0]		Addr_ROM_0,
						input			[8:0]		Addr_ROM_1,
						input			[8:0]		Addr_ROM_2,
						input			[8:0]		Addr_ROM_3,
						input			[8:0]		Addr_ROM_4,
						input			[8:0]		Addr_ROM_5,
						input			[8:0]		Addr_ROM_6,
						input			[8:0]		Addr_ROM_7,
						input			[8:0]		Addr_ROM_8,
						input			[8:0]		Addr_ROM_9,
						input			[8:0]		Addr_ROM_10,
						input			[8:0]		Addr_ROM_11,
						input			[8:0]		Addr_ROM_12,
						input			[8:0]		Addr_ROM_13,
						input			[8:0]		Addr_ROM_14,
						input			[8:0]		Addr_ROM_15,
						input			[8:0]		Addr_ROM_16,
						input			[8:0]		Addr_ROM_17,
						input			[8:0]		Addr_ROM_18,
						input			[8:0]		Addr_ROM_19,
						//Output
						output			[31:0]		Q_ROM_0,
						output			[31:0]		Q_ROM_1,
						output			[31:0]		Q_ROM_2,
						output			[31:0]		Q_ROM_3,
						output			[31:0]		Q_ROM_4,
						output			[31:0]		Q_ROM_5,
						output			[31:0]		Q_ROM_6,
						output			[31:0]		Q_ROM_7,
						output			[31:0]		Q_ROM_8,
						output			[31:0]		Q_ROM_9,
						output			[31:0]		Q_ROM_10,
						output			[31:0]		Q_ROM_11,
						output			[31:0]		Q_ROM_12,
						output			[31:0]		Q_ROM_13,
						output			[31:0]		Q_ROM_14,
						output			[31:0]		Q_ROM_15,
						output			[31:0]		Q_ROM_16,
						output			[31:0]		Q_ROM_17,
						output			[31:0]		Q_ROM_18,
						output			[31:0]		Q_ROM_19
					);



//==============================================================================
ann_rom_0 	ROM_0	(
						.address			(Addr_ROM_0),
						.clock				(iClk),
						.q					(Q_ROM_0)
					);

ann_rom_1 	ROM_1	(
						.address			(Addr_ROM_1),
						.clock				(iClk),
						.q					(Q_ROM_1)
					);
					
ann_rom_2 	ROM_2	(
						.address			(Addr_ROM_2),
						.clock				(iClk),
						.q					(Q_ROM_2)
					);
					
ann_rom_3 	ROM_3	(
						.address			(Addr_ROM_3),
						.clock				(iClk),
						.q					(Q_ROM_3)
					);
					
ann_rom_4 	ROM_4	(
						.address			(Addr_ROM_4),
						.clock				(iClk),
						.q					(Q_ROM_4)
					);

ann_rom_5 	ROM_5	(
						.address			(Addr_ROM_5),
						.clock				(iClk),
						.q					(Q_ROM_5)
					);

ann_rom_6 	ROM_6	(
						.address			(Addr_ROM_6),
						.clock				(iClk),
						.q					(Q_ROM_6)
					);
					
ann_rom_7 	ROM_7	(
						.address			(Addr_ROM_7),
						.clock				(iClk),
						.q					(Q_ROM_7)
					);
					
ann_rom_8 	ROM_8	(
						.address			(Addr_ROM_8),
						.clock				(iClk),
						.q					(Q_ROM_8)
					);
					
ann_rom_9 	ROM_9	(
						.address			(Addr_ROM_9),
						.clock				(iClk),
						.q					(Q_ROM_9)
					);

ann_rom_10 	ROM_10	(
						.address			(Addr_ROM_10),
						.clock				(iClk),
						.q					(Q_ROM_10)
					);

ann_rom_11 	ROM_11	(
						.address			(Addr_ROM_11),
						.clock				(iClk),
						.q					(Q_ROM_11)
					);
					
ann_rom_12 	ROM_12	(
						.address			(Addr_ROM_12),
						.clock				(iClk),
						.q					(Q_ROM_12)
					);
					
ann_rom_13 	ROM_13	(
						.address			(Addr_ROM_13),
						.clock				(iClk),
						.q					(Q_ROM_13)
					);
					
ann_rom_14 	ROM_14	(
						.address			(Addr_ROM_14),
						.clock				(iClk),
						.q					(Q_ROM_14)
					);

ann_rom_15 	ROM_15	(
						.address			(Addr_ROM_15),
						.clock				(iClk),
						.q					(Q_ROM_15)
					);

ann_rom_16 	ROM_16	(
						.address			(Addr_ROM_16),
						.clock				(iClk),
						.q					(Q_ROM_16)
					);
					
ann_rom_17 	ROM_17	(
						.address			(Addr_ROM_17),
						.clock				(iClk),
						.q					(Q_ROM_17)
					);
					
ann_rom_18 	ROM_18	(
						.address			(Addr_ROM_18),
						.clock				(iClk),
						.q					(Q_ROM_18)
					);
					
ann_rom_19 	ROM_19	(
						.address			(Addr_ROM_19),
						.clock				(iClk),
						.q					(Q_ROM_19)
					);

endmodule
