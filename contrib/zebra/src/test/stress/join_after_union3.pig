register $zebraJar;
--fs -rmr $outputDir


--a1 = LOAD '$inputDir/25Munsorted1' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1');
--a2 = LOAD '$inputDir/25Munsorted2' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1');
--a3 = LOAD '$inputDir/25Munsorted3' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1');
--a4 = LOAD '$inputDir/25Munsorted4' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1');

--sort1 = order a1 by long1 parallel 6;
--sort2 = order a2 by long1 parallel 5;
--sort3 = order a3 by long1 parallel 7;
--sort4 = order a4 by long1 parallel 4;

--store sort1 into '$outputDir/25Msorted11' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');
--store sort2 into '$outputDir/25Msorted21' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');
--store sort3 into '$outputDir/25Msorted31' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');
--store sort4 into '$outputDir/25Msorted41' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');


--joinl = LOAD '$outputDir/25Msorted11,$outputDir/25Msorted21' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1', 'sorted');
--joinll = order joinl by long1 parallel 7;
--store joinll into '$outputDir/unionl1' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');


--joinr = LOAD '$outputDir/25Msorted31,$outputDir/25Msorted41' USING org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1', 'sorted');
--joinrr = order joinr by long1 parallel 4;
--store joinrr into '$outputDir/unionr1' using org.apache.hadoop.zebra.pig.TableStorer('[count,seed,int1,str2,long1]');


rec1 = load '$outputDir/unionl1' using org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1', 'sorted');
rec2 = load '$outputDir/unionr1' using org.apache.hadoop.zebra.pig.TableLoader('count,seed,int1,str2,long1', 'sorted');


joina = join rec1 by long1, rec2 by long1 using "merge" ;

E = foreach joina  generate $0 as count,  $1 as seed,  $2 as int1,  $3 as str2, $4 as long1;
joinE = order E by long1 parallel 25;

--limitedVals = LIMIT joina 10;
--dump limitedVals;

store joinE into '$outputDir/join_after_union_13' using org.apache.hadoop.zebra.pig.TableStorer('');             
