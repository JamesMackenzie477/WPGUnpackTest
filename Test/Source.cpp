#include <iostream>
#include <Windows.h>
#include <zlib.h>

using namespace std;

// defines the unique fourcc code used to identify the file format
#define FOURCC 0x474B5052
// defines the max length of a package name
#define MAX_PACK_NAME 0x80

// definition of the structure of a package file header
typedef struct _PACKAGE_HEADER
{
	// the package fourcc code
	DWORD FourCC;
	// the package version
	DWORD Version;
	// contains the package root name	
	CHAR PackageRoot[MAX_PACK_NAME];
	// contains the number of sections within the package
	DWORD NumberOfSections;
} PACKAGE_HEADER, *PPACKAGE_HEADER;

// definition of the structure of a package file section
typedef struct _PACKAGE_SECTION
{
	// the name of the file accociated with the section
	CHAR FileName[MAX_PACK_NAME]; // 0x0
								  // the offset of the data block from the base of the file
	DWORD DataOffset; // 0x80
					  // the size of the data block
	DWORD DataSize; // 0x84
					// contains information on whether the data is encrypted or compressed
					// and with bitmask 1 to see if the data is compressed
					// and with bitmast 2 to see if data is encrypted
	DWORD DataInfo; // 0x88
} PACKAGE_SECTION, *PPACKAGE_SECTION;

template<class T> T __ROL__(T value, int count)
{
	const unsigned int nbits = sizeof(T) * 8;

	if (count > 0)
	{
		count %= nbits;
		T high = value >> (nbits - count);
		if (T(-1) < 0) // signed value
			high &= ~((T(-1) << count));
		value <<= count;
		value |= high;
	}
	else
	{
		count = -count % nbits;
		T low = value << (nbits - count);
		value >>= count;
		value |= low;
	}
	return value;
}

// rotates a four byte value left
inline unsigned int __ROL4__(unsigned int value, int count) { return __ROL__((unsigned int)value, count); }
inline unsigned int __ROR4__(unsigned int value, int count) { return __ROL__((unsigned int)value, -count); };

#define BYTEn(x, n)   (*((BYTE*)&(x)+n))
#define BYTE1(x)   BYTEn(x,  1) 

// these arrays contains data that will be accessed with an offset during class construction
const DWORD dword_AF9800[] =
{
	137377848,
	3370182696,
	220277805,
	2258805798,
	3485715471,
	3469925406,
	2209591347,
	2293282872,
	2409868335,
	1080057888,
	1162957845,
	3351495687,
	1145062404,
	1331915823,
	1264805931,
	1263753243,
	3284385795,
	1113743394,
	53686323,
	2243015733,
	153167913,
	2158010400,
	3269648418,
	2275648551,
	3285438483,
	2173800465,
	17895441,
	100795398,
	202382364,
	2360392764,
	103953462,
	1262700555,
	3487820847,
	2290124808,
	1281387564,
	2292230184,
	118690839,
	3300967428,
	101848086,
	3304125492,
	3267543042,
	1161905157,
	3252805665,
	3335705622,
	255015999,
	221330493,
	2390920206,
	2291177496,
	136325160,
	1312967694,
	3337810998,
	238173246,
	2241963045,
	3388078137,
	218172429,
	3486768159,
	3369130008,
	186853419,
	1180853286,
	1249015866,
	119743527,
	253963311,
	3253858353,
	1114796082,
	1111638018,
	3302020116,
	1094795265,
	3233857536,
	1131638835,
	1197696039,
	2359340076,
	2340653067,
	3354653751,
	2376182829,
	2155905024,
	252910623,
	3401762826,
	203435052,
	2325915690,
	70267956,
	3268595730,
	184748043,
	3470978094,
	3387025449,
	1297177629,
	2224067604,
	135272472,
	3371235384,
	1196643351,
	2393025582,
	134219784,
	3317810181,
	51580947,
	3452029965,
	2256700422,
	2310125625,
	3488873535,
	1299283005,
	3250700289,
	20000817,
	3320968245,
	2323810314,
	1247963178,
	2175905841,
	3251752977,
	2105376,
	3352548375,
	33685506,
	35790882,
	67109892,
	1214277672,
	1097953329,
	117638151,
	3419658267,
	2375130141,
	2308020249,
	1096900641,
	2394078270,
	3336758310,
	1230067737,
	3453082653,
	1095847953,
	2156957712,
	3436239900,
	2324863002,
	2208538659,
	2342758443,
	3234910224,
	2172747777,
	251857935,
	1195590663,
	168957978,
	3286491171,
	3437292588,
	2374077453,
	2410921023,
	2257753110,
	1265858619,
	1280334876,
	2191695906,
	2174853153,
	1130586147,
	52633635,
	1296124941,
	3368077320,
	2391972894,
	2358287388,
	171063354,
	201329676,
	237120558,
	2326968378,
	1315073070,
	2408815647,
	1246910490,
	3270701106,
	2190643218,
	3287543859,
	1229015049,
	1215330360,
	3435187212,
	85005333,
	3421763643,
	1081110576,
	1165063221,
	1332968511,
	87110709,
	1052688,
	50528259,
	1147167780,
	1298230317,
	3334652934,
	1148220468,
	3318862869,
	2226172980,
	3403868202,
	151062537,
	1181905974,
	152115225,
	3472030782,
	1077952512,
	34738194,
	3235962912,
	2377235517,
	83952645,
	3404920890,
	16842753,
	3237015600,
	170010666,
	1314020382,
	2309072937,
	1179800598,
	1128480771,
	2239857669,
	68162580,
	2306967561,
	2341705755,
	2159063088,
	3319915557,
	1212172296,
	1232173113,
	2274595863,
	3438345276,
	236067870,
	2189590530,
	18948129,
	2357234700,
	185800731,
	1330863135,
	1198748727,
	1146115092,
	2192748594,
	219225117,
	86058021,
	1329810447,
	0,
	1178747910,
	3454135341,
	1213224984,
	1112690706,
	3420710955,
	1316125758,
	3402815514,
	3384920073,
	3455188029,
	3158064,
	2240910357,
	1164010533,
	204487740,
	2259858486,
	3303072804,
	2343811131,
	1282440252,
	235015182,
	1079005200,
	154220601,
	102900774,
	36843570,
	2223014916,
	1231120425,
	2207485971,
	120796215,
	3353601063,
	69215268,
	2225120292,
	3418605579,
	1129533459,
	167905290,
	2273543175,
	3385972761,
	1279282188,
	2206433283,
	2407762959,
	3468872718,
	187906107,
	1245857802,
	2276701239
};

const DWORD dword_AF9400[] =
{
	2712152457,
	2172913029,
	3537114822,
	3553629123,
	1347687492,
	287055117,
	2695638156,
	556016901,
	1364991309,
	1128268611,
	270014472,
	303832590,
	1364201793,
	4043062476,
	3267889866,
	1667244867,
	539502600,
	1078199364,
	538976256,
	2442927501,
	3772784832,
	3806339778,
	3234334920,
	320083719,
	2711889285,
	2206994319,
	50332419,
	1937259339,
	3015195531,
	319820547,
	3536851650,
	3807129294,
	1886400576,
	2156661900,
	859586319,
	2695374984,
	842019330,
	3520863693,
	4076091078,
	1886663748,
	3773574348,
	2442401157,
	50858763,
	1398019911,
	1348213836,
	1398283083,
	2981903757,
	16777473,
	539239428,
	270277644,
	1936732995,
	2425886856,
	269488128,
	3234598092,
	4075827906,
	3520600521,
	539765772,
	3823380423,
	1919955522,
	2206204803,
	2476219275,
	3520074177,
	2189690502,
	3251112393,
	1616912448,
	1347424320,
	2745181059,
	3823643595,
	17566989,
	2998154886,
	2459704974,
	1129058127,
	3014932359,
	1381505610,
	3267626694,
	1886926920,
	2728666758,
	303043074,
	2745970575,
	3520337349,
	1633689921,
	3284140995,
	2964599940,
	1094713665,
	1380979266,
	1903967565,
	2173439373,
	526344,
	320610063,
	2442664329,
	0,
	286791945,
	263172,
	1397756739,
	4092868551,
	3789562305,
	4059839949,
	1920218694,
	590098191,
	589571847,
	2964336768,
	2206731147,
	34344462,
	2745707403,
	2728403586,
	1651256910,
	2475692931,
	1095503181,
	1634216265,
	1887190092,
	17303817,
	34081290,
	3015458703,
	3823906767,
	4092605379,
	3250849221,
	2206467975,
	269751300,
	4076617422,
	1617175620,
	3537641166,
	573320718,
	1128794955,
	303569418,
	33818118,
	555753729,
	1667771211,
	1650730566,
	33554946,
	4059313605,
	2458915458,
	2189953674,
	789516,
	3014669187,
	1920745038,
	3503296704,
	1920481866,
	1128531783,
	2459178630,
	3789825477,
	572794374,
	2155872384,
	2712415629,
	3554418639,
	2711626113,
	808464384,
	859059975,
	2729193102,
	842282502,
	286528773,
	572531202,
	808990728,
	4042536132,
	2745444231,
	1094976837,
	1078725708,
	2172649857,
	3790088649,
	2156135556,
	2475956103,
	825505029,
	3284667339,
	3268153038,
	809253900,
	1903178049,
	286265601,
	3284404167,
	2173176201,
	1903441221,
	4093131723,
	3537377994,
	4042799304,
	2425623684,
	1364728137,
	2189427330,
	3234071748,
	4093394895,
	1095240009,
	825768201,
	1667508039,
	3233808576,
	3284930511,
	3553892295,
	2964863112,
	51121935,
	2190216846,
	1111491138,
	589308675,
	2442137985,
	1617701964,
	3554155467,
	2695111812,
	808727556,
	4059050433,
	1078462536,
	3267363522,
	1668034383,
	826031373,
	556543245,
	1077936192,
	2998681230,
	842808846,
	2965126284,
	3250586049,
	2728929930,
	2998418058,
	1112280654,
	1364464965,
	859323147,
	3504086220,
	1617438792,
	1937522511,
	2426150028,
	3503823048,
	1112017482,
	1381242438,
	1936996167,
	2694848640,
	3790351821,
	1111754310,
	2981377413,
	589835019,
	1633953093,
	4076354250,
	3823117251,
	2981640585,
	2981114241,
	2476482447,
	1381768782,
	4059576777,
	3806602950,
	2997891714,
	825241857,
	3806866122,
	1634479437,
	1398546255,
	3773048004,
	4042272960,
	3251375565,
	2156398728,
	303306246,
	842545674,
	1347950664,
	3503559876,
	1650467394,
	556280073,
	50595591,
	858796803,
	3773311176,
	320346891,
	17040645,
	1903704393,
	2425360512,
	1650993738,
	573057546,
	2459441802
};

const DWORD dword_AF9000[] =
{
	943196208,
	3894986976,
	741149985,
	2753988258,
	3423588291,
	3693006546,
	2956166067,
	3090712752,
	2888798115,
	1612726368,
	1410680145,
	3288844227,
	1141130304,
	1815039843,
	1747667811,
	1478183763,
	3221472195,
	1612857954,
	808649523,
	3023406513,
	673777953,
	2686484640,
	3760374498,
	2754054051,
	3490956243,
	2417066385,
	269549841,
	67503618,
	471600144,
	3158084784,
	875955762,
	1208699715,
	3962556387,
	2282260608,
	1814842464,
	2821228704,
	337053459,
	3288646848,
	336987666,
	4097098992,
	3221406402,
	1141196097,
	3760308705,
	3558262482,
	1010765619,
	1010634033,
	2349764226,
	2551744656,
	673712160,
	1276005954,
	4097230578,
	1010699826,
	2753922465,
	4164536817,
	202181889,
	3693072339,
	3625502928,
	673909539,
	1680229986,
	2017086066,
	606537507,
	741281571,
	4029792753,
	1882342002,
	1073889858,
	3558130896,
	1073824065,
	3221274816,
	1882407795,
	1680295779,
	2888600736,
	2282457987,
	4097296371,
	2888666529,
	2147516544,
	471797523,
	3356150466,
	741084192,
	2821360290,
	875824176,
	3490890450,
	134941443,
	3962490594,
	3895052769,
	1545424209,
	2484372624,
	404228112,
	4164471024,
	1410811731,
	2888732322,
	134744064,
	3288712641,
	269681427,
	3423456705,
	2215020162,
	3090778545,
	4232040435,
	2084392305,
	3221340609,
	808517937,
	4097164785,
	2282392194,
	1747602018,
	2956034481,
	3490824657,
	538968096,
	3558328275,
	131586,
	539099682,
	67372032,
	1747470432,
	1882276209,
	67569411,
	3625700307,
	2619182481,
	2551810449,
	1612792161,
	3158216370,
	3827746530,
	1478052177,
	3692940753,
	1343308113,
	2417000592,
	3692874960,
	2551876242,
	2686682019,
	2821426083,
	3490758864,
	2147582337,
	202313475,
	1141327683,
	404359698,
	3760440291,
	3962359008,
	2349698433,
	3158282163,
	2484504210,
	2017151859,
	1545358416,
	2686616226,
	2686550433,
	1612923747,
	539165475,
	1275940161,
	3356018880,
	2619248274,
	2619116688,
	943327794,
	202116096,
	741215778,
	3090844338,
	1814974050,
	2619314067,
	1478117970,
	4029858546,
	2417132178,
	4029924339,
	1208568129,
	2016954480,
	3423390912,
	336921873,
	4164668403,
	1882210416,
	1949648241,
	2084523891,
	875889969,
	269484048,
	197379,
	1680098400,
	1814908257,
	3288778434,
	1949582448,
	3558196689,
	3023340720,
	3895118562,
	134809857,
	1949714034,
	404293905,
	4231974642,
	1073758272,
	269615634,
	3760242912,
	3158150577,
	67437825,
	4164602610,
	65793,
	4029726960,
	673843746,
	1545490002,
	2821294497,
	1410745938,
	1073955651,
	2214954369,
	336856080,
	2282326401,
	2551942035,
	2955968688,
	3827680737,
	1208502336,
	2017020273,
	2484570003,
	4231843056,
	471731730,
	2147648130,
	539033889,
	2349632640,
	404425491,
	1545555795,
	1949779827,
	1410614352,
	2956100274,
	471665937,
	606405921,
	1276071747,
	0,
	1141261890,
	3962424801,
	1477986384,
	1343373906,
	3895184355,
	2084458098,
	3625634514,
	3356084673,
	4231908849,
	808452144,
	2484438417,
	1680164193,
	1010568240,
	3023472306,
	3827614944,
	3090910131,
	2084326512,
	202247682,
	1343242320,
	943262001,
	606471714,
	808583730,
	2214888576,
	1747536225,
	2417197971,
	876021555,
	3827812323,
	606340128,
	2753856672,
	3356216259,
	1343439699,
	134875650,
	2215085955,
	3625568721,
	1275874368,
	2147713923,
	2349830019,
	3423522498,
	943393587,
	1208633922,
	3023538099
};

const DWORD dword_AF8C00[] =
{
	696885672,
	92635524,
	382128852,
	331600848,
	340021332,
	487395612,
	747413676,
	621093156,
	491606364,
	54739776,
	403181592,
	504238620,
	289493328,
	1020063996,
	181060296,
	591618912,
	671621160,
	71581764,
	536879136,
	495817116,
	549511392,
	583197408,
	147374280,
	386339604,
	629514660,
	261063564,
	50529024,
	994800504,
	999011256,
	318968592,
	314757840,
	785310444,
	809529456,
	210534540,
	1057960764,
	680042664,
	839004720,
	500027868,
	919007988,
	876900468,
	751624428,
	361075092,
	185271048,
	390550356,
	474763356,
	457921368,
	1032696252,
	16843008,
	604250148,
	470552604,
	860058480,
	411603096,
	268439568,
	214745292,
	851636976,
	432656856,
	738992172,
	667411428,
	843215472,
	58950528,
	462132120,
	297914832,
	109478532,
	164217288,
	541089888,
	272650320,
	595829664,
	734782440,
	218956044,
	914797236,
	512660124,
	256852812,
	931640244,
	441078360,
	113689284,
	944271480,
	646357668,
	302125584,
	797942700,
	365285844,
	557932896,
	63161280,
	881111220,
	21053760,
	306336336,
	1028485500,
	227377548,
	134742024,
	521081628,
	428446104,
	0,
	420024600,
	67371012,
	323179344,
	935850996,
	566354400,
	1036907004,
	910586484,
	789521196,
	654779172,
	813740208,
	193692552,
	235799052,
	730571688,
	578986656,
	776888940,
	327390096,
	223166796,
	692674920,
	1011642492,
	151585032,
	168428040,
	1066382268,
	802153452,
	868479984,
	96846276,
	126321540,
	335810580,
	1053750012,
	608460900,
	516870876,
	772678188,
	189481800,
	436867608,
	101057028,
	553722144,
	726360936,
	642146916,
	33686016,
	902164980,
	310547088,
	176849544,
	202113036,
	864269232,
	1045328508,
	281071824,
	977957496,
	122110788,
	377918100,
	633725412,
	637936164,
	8421504,
	764256684,
	533713884,
	562143648,
	805318704,
	923218740,
	781099692,
	906375732,
	352653588,
	570565152,
	940060728,
	885321972,
	663200676,
	88424772,
	206323788,
	25264512,
	701096424,
	75792516,
	394761108,
	889532724,
	197903304,
	248431308,
	1007431740,
	826372464,
	285282576,
	130532292,
	160006536,
	893743476,
	1003222008,
	449499864,
	952692984,
	344232084,
	424235352,
	42107520,
	80003268,
	1070593020,
	155795784,
	956903736,
	658989924,
	12632256,
	265274316,
	398971860,
	948482232,
	252642060,
	244220556,
	37896768,
	587408160,
	293704080,
	743202924,
	466342872,
	612671652,
	872689716,
	834793968,
	138952776,
	46318272,
	793731948,
	1024274748,
	755835180,
	4210752,
	1049539260,
	1041117756,
	1015853244,
	29475264,
	713728680,
	982168248,
	240009804,
	356864340,
	990589752,
	483184860,
	675831912,
	1062171516,
	478974108,
	415813848,
	172638792,
	373707348,
	927429492,
	545300640,
	768467436,
	105267780,
	897954228,
	722150184,
	625303908,
	986379000,
	600040416,
	965325240,
	830583216,
	529503132,
	508449372,
	969535992,
	650568420,
	847426224,
	822161712,
	717939432,
	760045932,
	525292380,
	616882404,
	817950960,
	231588300,
	143163528,
	369496596,
	973746744,
	407392344,
	348442836,
	574775904,
	688464168,
	117900036,
	855847728,
	684253416,
	453710616,
	84214020,
	961114488,
	276861072,
	709517928,
	705307176,
	445289112
};

// contains the encrypted file data
const unsigned char hi[] = {
	0x42, 0x03, 0x00, 0x00, 0xD6, 0xDB, 0xB5, 0x21, 0xA6, 0xCC, 0x25, 0x9E, 0xD1, 0xEA, 0xCA, 0xF0,
	0x9A, 0xCD, 0xF2, 0xDA, 0x01, 0x94, 0x3C, 0x99, 0x0B, 0x35, 0x51, 0xB5, 0xC5, 0x4F, 0x26, 0x2F,
	0x35, 0x5A, 0x47, 0x95, 0xE5, 0xBE, 0xC0, 0x78, 0xE2, 0xE8, 0x2F, 0x37, 0xE2, 0xBB, 0x91, 0x35,
	0xAB, 0xD6, 0xD2, 0x42, 0x7D, 0x95, 0x7C, 0x3D, 0x85, 0x95, 0xE2, 0x65, 0x1C, 0x96, 0xE7, 0x46,
	0xB1, 0x70, 0x73, 0x71, 0x0A, 0xAC, 0x35, 0xFC, 0xF8, 0xA0, 0x87, 0x53, 0x03, 0xA0, 0x6E, 0x48,
	0x85, 0x45, 0xCA, 0xAD, 0x28, 0x2F, 0x6F, 0x91, 0xC1, 0xAD, 0x8C, 0x41, 0xA9, 0x54, 0x33, 0x57,
	0x58, 0xC1, 0xFE, 0x0C, 0x63, 0xE6, 0x4A, 0x29, 0x0A, 0x57, 0x20, 0xBC, 0x21, 0x90, 0xC6, 0x13,
	0x90, 0x96, 0x4C, 0xF2, 0x96, 0x0B, 0xB8, 0x55, 0x6E, 0x77, 0x19, 0x97, 0xD7, 0x9E, 0x5B, 0x26,
	0xDC, 0x44, 0x9D, 0xFD, 0x3D, 0x14, 0x0E, 0xAB, 0xAF, 0x8F, 0x11, 0x6C, 0x08, 0x30, 0x64, 0x22,
	0xFF, 0xF1, 0x73, 0x92, 0x0B, 0x4D, 0x6D, 0xA4, 0x2A, 0x64, 0xBA, 0xBC, 0xFF, 0x0A, 0xA7, 0xD6,
	0x4F, 0x69, 0xB3, 0x46, 0xF3, 0xC3, 0xE1, 0xA5, 0x7C, 0x4A, 0xAA, 0x44, 0xE1, 0xD6, 0x7E, 0xE1,
	0x5B, 0x72, 0x53, 0xC2, 0x15, 0xFA, 0x02, 0x17, 0xDF, 0xEE, 0x3A, 0xD6, 0xE2, 0x79, 0x49, 0xC6,
	0x5B, 0x19, 0x57, 0xE2, 0x4B, 0x3B, 0xDD, 0xD4, 0x99, 0x93, 0xBF, 0x0C, 0x0A, 0x4C, 0x48, 0x96,
	0x90, 0x5A, 0x35, 0x44, 0x9E, 0x2B, 0x38, 0x0A, 0x23, 0xF0, 0xC9, 0x1B, 0x45, 0x56, 0x52, 0xC2,
	0x2B, 0xFB, 0x5C, 0x4A, 0x9C, 0x88, 0x4E, 0x75, 0xEF, 0x3D, 0xF4, 0x1E, 0x79, 0x3E, 0x84, 0x91,
	0xF4, 0xB4, 0x59, 0xA8, 0x02, 0xF2, 0xA7, 0x6B, 0xBE, 0x6E, 0xAA, 0x99, 0x80, 0x2C, 0x9E, 0xC5,
	0xD9, 0x7E, 0xE9, 0x59, 0x4E, 0x5F, 0x84, 0x21, 0xE5, 0xFE, 0x9E, 0x92, 0xEA, 0x65, 0x16, 0x34,
	0xF5, 0x47, 0xE9, 0x38, 0x08, 0xE6, 0xAD, 0x84, 0x43, 0x8F, 0x5B, 0xB3, 0xC3, 0x9E, 0x2C, 0x68,
	0x0F, 0x80, 0xF0, 0xF2, 0xFC, 0x83, 0x35, 0x14, 0x98, 0xFF, 0x22, 0x3A, 0xA0, 0x74, 0x2A, 0xD6,
	0x13, 0xB1, 0x54, 0x46, 0x94, 0x7A, 0x47, 0x2F, 0xA6, 0x35, 0xCD, 0x61, 0x70, 0x8F, 0x08, 0x10,
	0xD6, 0xAE, 0xAA, 0xEA, 0x1A, 0x28, 0x14, 0x6A, 0xB9, 0x70, 0xF6, 0x17, 0x5E, 0x05, 0xF7, 0xEF,
	0x5C, 0xB8, 0xB4, 0x23, 0x89, 0x99, 0x6A, 0x71, 0x46, 0x94, 0xDB, 0x7F, 0x5E, 0xBC, 0xDB, 0xD5,
	0xD4, 0xA9, 0x85, 0x61, 0xCE, 0xEF, 0xC9, 0x51, 0x74, 0x59, 0x98, 0x2A, 0xA0, 0xD8, 0x80, 0x66,
	0xFD, 0x66, 0x9B, 0xA2, 0xBC, 0x96, 0xCB, 0xB1, 0x0A, 0xEE, 0x7C, 0x46, 0xD7, 0xB5, 0xE6, 0xA0,
	0x97, 0xCE, 0x70, 0x86, 0x74, 0xD5, 0x6A, 0xCD, 0xDC, 0x37, 0x10, 0x74, 0x40, 0x18, 0xD0, 0xB7,
	0x41, 0xE9, 0x99, 0xFE, 0x2B, 0xC4, 0x9E, 0x35, 0x91, 0x35, 0x1F, 0xCC, 0xC1, 0x0B, 0x83, 0x06,
	0x60, 0x41, 0x4E, 0xB9, 0x91, 0xEB, 0x2D, 0xF0, 0xA3, 0xA9, 0x85, 0x6A, 0xF8, 0x17, 0x75, 0x8A,
	0x11, 0x2F, 0x96, 0xB8, 0xF0, 0x5F, 0xEB, 0xBD, 0xE7, 0xA0, 0x39, 0xF7, 0x91, 0x68, 0xA3, 0xFF,
	0xE4, 0x17, 0x4B, 0x01, 0x67, 0x7E, 0xE5, 0xCF, 0xFC, 0x09, 0x18, 0xC2, 0xD2, 0x18, 0x84, 0x59,
	0x87, 0x91, 0x03, 0x89, 0x05, 0x9F, 0x01, 0x9C, 0xD5, 0xB6, 0xA7, 0xE8, 0xA2, 0xC5, 0xEC, 0x2C,
	0x04, 0x51, 0x3D, 0x2B, 0x38, 0xC7, 0xFE, 0x49, 0xBA, 0x41, 0xD8, 0x7E, 0xBF, 0x21, 0x2E, 0xF4,
	0x0E, 0x30, 0xFD, 0x73, 0xA4, 0xF7, 0x95, 0xF8, 0x5B, 0x74, 0x9A, 0xD6, 0x68, 0xC4, 0x0B, 0x9D,
	0x9F, 0x57, 0x5E, 0x6A, 0xC2, 0xDA, 0x1E, 0xBD, 0x5B, 0xB5, 0xD2, 0xA1, 0xC0, 0x0F, 0xD9, 0xA4,
	0x3E, 0xF8, 0xB4, 0xBE, 0x5E, 0x74, 0xBE, 0xBA, 0x06, 0x19, 0x4C, 0x2C, 0xD3, 0xE7, 0xBA, 0x68,
	0x43, 0x30, 0x78, 0x17, 0xBE, 0x95, 0x60, 0x23, 0xD3, 0x8D, 0x0F, 0x43, 0xE3, 0xAA, 0xE9, 0xC0,
	0x84, 0xD1, 0xDA, 0xB4, 0x99, 0x7E, 0x9E, 0xB9, 0xF4, 0x68, 0x21, 0x80, 0x01, 0x9B, 0x29, 0xC6,
	0x59, 0x58, 0xC8, 0x66, 0x24, 0xBD, 0x72, 0xF8, 0x3E, 0xB0, 0x9D, 0x41, 0x5A, 0x69, 0xD0, 0xF0,
	0xA6, 0xDA, 0x22, 0x79, 0xC4, 0x43, 0xD3, 0x61, 0xBC, 0x94, 0x8A, 0x49, 0xAD, 0x96, 0x6B, 0x07,
	0x29, 0x1F, 0xA1, 0xD5, 0x39, 0x82, 0xA5, 0x3D, 0x32, 0x4C, 0x48, 0xC6, 0x22, 0x29, 0x43, 0x3E,
	0xBB, 0x55, 0xD1, 0x21, 0x05, 0x7B, 0x84, 0xBB, 0x7B, 0x13, 0x5C, 0xE5, 0x02, 0x5B, 0x52, 0xCD,
	0xE3, 0x73, 0xD4, 0x67, 0xC2, 0xFD, 0x81, 0x25, 0xDC, 0xBC, 0x64, 0x5E, 0x98, 0xD0, 0xD3, 0xE0,
	0xCB, 0x53, 0x56, 0x7E, 0xD6, 0x08, 0x17, 0xD2, 0x16, 0x35, 0xBA, 0xBD, 0x52, 0x58, 0x94, 0x91,
	0x46, 0x8C, 0xC6, 0x8C, 0x90, 0x40, 0xA9, 0xED, 0x24, 0xF8, 0x8B, 0xE0, 0x33, 0xB0, 0x52, 0x3E,
	0x8B, 0xE9, 0xD2, 0xBC, 0xAD, 0x6A, 0x3E, 0x3D, 0x1A, 0xA2, 0xB6, 0xC0, 0x7F, 0x8E, 0xF8, 0xD3,
	0xD7, 0x8C, 0xC7, 0xA7, 0xCE, 0xE1, 0x75, 0x39, 0xE1, 0x79, 0x35, 0xC5, 0xCA, 0xFE, 0xD2, 0xB4,
	0x38, 0xE8, 0xA1, 0x95, 0x8A, 0xFB, 0xAA, 0xEE, 0xE8, 0xF5, 0x70, 0xCA, 0x29, 0x23, 0x7D, 0x8F,
	0x41, 0x3F, 0xE1, 0x7F, 0x59, 0xD3, 0x99, 0xF0, 0x65, 0x42, 0x74, 0x54, 0x50, 0xC4, 0x33, 0xD5,
	0x9C, 0x01, 0x84, 0xA5, 0xD8, 0xD9, 0xD3, 0x03, 0x8A, 0x8D, 0x28, 0x1B, 0x39, 0x6F, 0xD9, 0xB8,
	0x5A, 0x3D, 0xA0, 0x04, 0xE2, 0xD9, 0x63, 0x34, 0x3E, 0xE4, 0xCF, 0x40, 0x24, 0x74, 0x90, 0x0B,
	0xD8, 0x56, 0x4A, 0xC0, 0x1A, 0x68, 0x2C, 0xFB, 0xE3, 0x06, 0x21, 0xAA, 0xE5, 0x44, 0xD8, 0x37,
	0x42, 0xE9, 0x3F, 0x19, 0xBA, 0x39, 0xB6, 0x73, 0xF6, 0xDF, 0x34, 0xB8, 0x59, 0xBC, 0x89, 0x2F,
	0xBC, 0xEE, 0xB3, 0x0E, 0x6C, 0x36, 0x2C, 0x19, 0x2D, 0x99, 0x64, 0x2A, 0xC0, 0x00, 0x55, 0x09,
	0x03, 0xD8, 0x5D, 0xB0, 0x4F, 0x62, 0x0D, 0x0D, 0x70, 0x5F, 0x6F, 0xFE, 0x67, 0xDC, 0x32, 0xDA,
	0x44, 0xA0, 0xC7, 0x35
};

// stores the first decryption block
const unsigned char FirstDecryptionBlock[] = {
	0x26, 0x8D, 0x66, 0xA7, 0x35, 0xA8, 0x1A, 0x81, 0x6F, 0xBA, 0xD9, 0xFA, 0x36, 0x16, 0x25, 0x01
};

// contains the decryption key
const unsigned char DecryptionKey[] = {
	0x00, 0x00, 0x00, 0x00, 0x26, 0x8D, 0x66, 0xA7, 0x35, 0xA8, 0x1A, 0x81, 0x6F, 0xBA, 0xD9, 0xFA, 0x36, 0x16, 0x25, 0x01,
	0x8D, 0x04, 0x6E, 0x7E, 0xB4, 0x52, 0x7F, 0xA5, 0xBF, 0xA2, 0x92, 0xC1, 0xFF, 0x55, 0xA4, 0x4E,
	0x1D, 0xE6, 0x11, 0xFA, 0x60, 0xAC, 0x3D, 0xB3, 0xBE, 0x66, 0x44, 0xD6, 0x95, 0x3C, 0xAE, 0xAF,
	0xEF, 0xC4, 0xC6, 0xF8, 0x56, 0x5B, 0x78, 0x23, 0x82, 0xD1, 0xE2, 0x86, 0x39, 0x81, 0x0A, 0xC4,
	0xC6, 0xB9, 0xBB, 0x88, 0x15, 0x73, 0x1A, 0x2B, 0x04, 0x18, 0x77, 0xE7, 0xBA, 0x7F, 0x51, 0x36,
	0xB1, 0xB3, 0xAF, 0xF9, 0x2B, 0x6C, 0x4A, 0x05, 0x6D, 0xBD, 0xF1, 0xB1, 0xBD, 0x05, 0xD1, 0x2E,
	0x76, 0x7B, 0x69, 0xE3, 0x91, 0x02, 0xF7, 0x39, 0xBD, 0x3B, 0xFB, 0x67, 0xC8, 0xE1, 0xAF, 0x1A,
	0x3C, 0xCE, 0xA1, 0x8B, 0x7B, 0x16, 0x22, 0xF0, 0x6D, 0xC5, 0x67, 0xE6, 0x0F, 0xD5, 0x83, 0xD5,
	0x80, 0x44, 0xA6, 0xE5, 0xD5, 0x93, 0x5E, 0xA1, 0x2F, 0x92, 0xE8, 0xEB, 0x7F, 0xE5, 0xB0, 0x38
};

// decrypts a block (pilfered from ida)
// 
DWORD DecryptBlock(PBYTE pKey, PBYTE pData, PBYTE pBuff)
{
	unsigned int v3 = *(DWORD*)(pData + 8);
	unsigned int v4 = v3;
	unsigned int v5 = *(DWORD*)pData;
	unsigned int v6 = *(DWORD*)(pData + 4);
	unsigned int v7 = *(DWORD*)(pData + 12);
	v3 = __ROL4__(v3, 8);
	v4 = __ROR4__(v4, 8);
	unsigned int v8 = (int)pKey;
	unsigned int v9 = v3 & 0xFF00FF | v4 & 0xFF00FF00;
	unsigned int v10 = v7;
	v7 = __ROL4__(v7, 8);
	v10 = __ROR4__(v10, 8);
	unsigned int v11 = v9;
	unsigned int v12 = v9 ^ *(DWORD*)(pKey + 0x8C);
	unsigned int v125 = v7 & 0xFF00FF | v10 & 0xFF00FF00;
	unsigned int v13 = v125 ^ v12 ^ *(DWORD*)(pKey + 0x90);
	unsigned int v14 = dword_AF8C00[(unsigned __int8)(v125 ^ v12 ^ *(BYTE*)(pKey + 0x90))] ^ dword_AF9000[BYTE1(v13)] ^ dword_AF9400[(unsigned __int8)((v125 ^ v12 ^ *(DWORD*)(pKey + 0x90)) >> 16)] ^ dword_AF9800[(v125 ^ v12 ^ *(DWORD*)(pKey + 0x90)) >> 24];
	unsigned int v15 = v14 + v12;
	unsigned int v16 = dword_AF8C00[(unsigned __int8)v15] ^ dword_AF9000[BYTE1(v15)] ^ dword_AF9400[(unsigned __int8)(v15 >> 16)] ^ dword_AF9800[v15 >> 24];
	unsigned int v17 = __ROR4__(v5, 8);
	v5 = __ROL4__(v5, 8);
	unsigned int v18 = dword_AF8C00[(unsigned __int8)(v16 + v14)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v16 + v14) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v16 + v14) >> 16)] ^ dword_AF9800[(unsigned int)(v16 + v14) >> 24];
	unsigned int v19 = (v18 + v16) ^ (v5 & 0xFF00FF | v17 & 0xFF00FF00);
	unsigned int v20 = __ROR4__(v6, 8);
	v6 = __ROL4__(v6, 8);
	unsigned int v21 = v18 ^ (v6 & 0xFF00FF | v20 & 0xFF00FF00);
	unsigned int v22 = v19 ^ *(DWORD*)(v8 + 0x84);
	unsigned int v23 = dword_AF8C00[(unsigned __int8)(v21 ^ v22 ^ *(BYTE*)(v8 + 0x88))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v21 ^ v22 ^ *(WORD*)(v8 + 0x88)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v21 ^ v22 ^ *(DWORD*)(v8 + 0x88)) >> 16)] ^ dword_AF9800[(v21 ^ v22 ^ *(DWORD*)(v8 + 0x88)) >> 24];
	unsigned int v24 = v23 + v22;
	unsigned int v25 = dword_AF8C00[(unsigned __int8)v24] ^ dword_AF9000[BYTE1(v24)] ^ dword_AF9400[(unsigned __int8)(v24 >> 16)] ^ dword_AF9800[v24 >> 24];
	unsigned int v26 = dword_AF8C00[(unsigned __int8)(v25 + v23)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v25 + v23) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v25 + v23) >> 16)] ^ dword_AF9800[(unsigned int)(v25 + v23) >> 24];
	unsigned int v126 = v26 ^ v125;
	unsigned int v27 = (v26 + v25) ^ v11;
	unsigned int v28 = v27 ^ *(DWORD*)(v8 + 0x7C);
	unsigned int v29 = dword_AF8C00[(unsigned __int8)(v126 ^ v28 ^ *(BYTE*)(v8 + 128))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v126 ^ v28 ^ *(WORD*)(v8 + 128)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v126 ^ (unsigned int)v28 ^ *(DWORD*)(v8 + 128)) >> 16)] ^ dword_AF9800[(v126 ^ (unsigned int)v28 ^ *(DWORD*)(v8 + 128)) >> 24];
	unsigned int v30 = v29 + v28;
	unsigned int v31 = dword_AF8C00[(unsigned __int8)v30] ^ dword_AF9000[BYTE1(v30)] ^ dword_AF9400[(unsigned __int8)(v30 >> 16)] ^ dword_AF9800[v30 >> 24];
	unsigned int v32 = dword_AF8C00[(unsigned __int8)(v31 + v29)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v31 + v29) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v31 + v29) >> 16)] ^ dword_AF9800[(unsigned int)(v31 + v29) >> 24];
	unsigned int v33 = v32 ^ v21;
	unsigned int v34 = (v32 + v31) ^ v19;
	unsigned int v35 = v34 ^ *(DWORD*)(v8 + 116);
	unsigned int v36 = dword_AF8C00[(unsigned __int8)(v33 ^ v35 ^ *(BYTE*)(v8 + 120))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v33 ^ v35 ^ *(WORD*)(v8 + 120)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v33 ^ (unsigned int)v35 ^ *(DWORD*)(v8 + 120)) >> 16)] ^ dword_AF9800[(v33 ^ (unsigned int)v35 ^ *(DWORD*)(v8 + 120)) >> 24];
	unsigned int v37 = v36 + v35;
	unsigned int v38 = dword_AF8C00[(unsigned __int8)v37] ^ dword_AF9000[BYTE1(v37)] ^ dword_AF9400[(unsigned __int8)(v37 >> 16)] ^ dword_AF9800[v37 >> 24];
	unsigned int v39 = dword_AF8C00[(unsigned __int8)(v38 + v36)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v38 + v36) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v38 + v36) >> 16)] ^ dword_AF9800[(unsigned int)(v38 + v36) >> 24];
	unsigned int v127 = v39 ^ v126;
	unsigned int v40 = (v39 + v38) ^ v27;
	unsigned int v41 = v40 ^ *(DWORD*)(v8 + 108);
	unsigned int v42 = dword_AF8C00[(unsigned __int8)(v127 ^ v41 ^ *(BYTE*)(v8 + 112))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v127 ^ v41 ^ *(WORD*)(v8 + 112)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v127 ^ (unsigned int)v41 ^ *(DWORD*)(v8 + 112)) >> 16)] ^ dword_AF9800[(v127 ^ (unsigned int)v41 ^ *(DWORD*)(v8 + 112)) >> 24];
	unsigned int v43 = v42 + v41;
	unsigned int v44 = dword_AF8C00[(unsigned __int8)v43] ^ dword_AF9000[BYTE1(v43)] ^ dword_AF9400[(unsigned __int8)(v43 >> 16)] ^ dword_AF9800[v43 >> 24];
	unsigned int v45 = dword_AF8C00[(unsigned __int8)(v44 + v42)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v44 + v42) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v44 + v42) >> 16)] ^ dword_AF9800[(unsigned int)(v44 + v42) >> 24];
	unsigned int v46 = v45 ^ v33;
	unsigned int v47 = (v45 + v44) ^ v34;
	unsigned int v48 = v47 ^ *(DWORD*)(v8 + 100);
	unsigned int v49 = dword_AF8C00[(unsigned __int8)(v46 ^ v48 ^ *(BYTE*)(v8 + 104))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v46 ^ v48 ^ *(WORD*)(v8 + 104)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v46 ^ (unsigned int)v48 ^ *(DWORD*)(v8 + 104)) >> 16)] ^ dword_AF9800[(v46 ^ (unsigned int)v48 ^ *(DWORD*)(v8 + 104)) >> 24];
	unsigned int v50 = v49 + v48;
	unsigned int v51 = dword_AF8C00[(unsigned __int8)v50] ^ dword_AF9000[BYTE1(v50)] ^ dword_AF9400[(unsigned __int8)(v50 >> 16)] ^ dword_AF9800[v50 >> 24];
	unsigned int v52 = dword_AF8C00[(unsigned __int8)(v51 + v49)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v51 + v49) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v51 + v49) >> 16)] ^ dword_AF9800[(unsigned int)(v51 + v49) >> 24];
	unsigned int v128 = v52 ^ v127;
	unsigned int v53 = (v52 + v51) ^ v40;
	unsigned int v54 = v53 ^ *(DWORD*)(v8 + 92);
	unsigned int v55 = dword_AF8C00[(unsigned __int8)(v128 ^ v54 ^ *(BYTE*)(v8 + 96))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v128 ^ v54 ^ *(WORD*)(v8 + 96)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v128 ^ (unsigned int)v54 ^ *(DWORD*)(v8 + 96)) >> 16)] ^ dword_AF9800[(v128 ^ (unsigned int)v54 ^ *(DWORD*)(v8 + 96)) >> 24];
	unsigned int v56 = v55 + v54;
	unsigned int v57 = dword_AF8C00[(unsigned __int8)v56] ^ dword_AF9000[BYTE1(v56)] ^ dword_AF9400[(unsigned __int8)(v56 >> 16)] ^ dword_AF9800[v56 >> 24];
	unsigned int v58 = dword_AF8C00[(unsigned __int8)(v57 + v55)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v57 + v55) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v57 + v55) >> 16)] ^ dword_AF9800[(unsigned int)(v57 + v55) >> 24];
	unsigned int v59 = (v58 + v57) ^ v47;
	unsigned int v60 = v58 ^ v46;
	unsigned int v61 = v59 ^ *(DWORD*)(v8 + 84);
	unsigned int v62 = dword_AF8C00[(unsigned __int8)(v60 ^ v61 ^ *(BYTE*)(v8 + 88))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v60 ^ v61 ^ *(WORD*)(v8 + 88)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v60 ^ (unsigned int)v61 ^ *(DWORD*)(v8 + 88)) >> 16)] ^ dword_AF9800[(v60 ^ (unsigned int)v61 ^ *(DWORD*)(v8 + 88)) >> 24];
	unsigned int v63 = v62 + v61;
	unsigned int v64 = dword_AF8C00[(unsigned __int8)v63] ^ dword_AF9000[BYTE1(v63)] ^ dword_AF9400[(unsigned __int8)(v63 >> 16)] ^ dword_AF9800[v63 >> 24];
	unsigned int v65 = dword_AF8C00[(unsigned __int8)(v64 + v62)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v64 + v62) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v64 + v62) >> 16)] ^ dword_AF9800[(unsigned int)(v64 + v62) >> 24];
	unsigned int v129 = v65 ^ v128;
	unsigned int v66 = (v65 + v64) ^ v53;
	unsigned int v67 = v66 ^ *(DWORD*)(v8 + 76);
	unsigned int v68 = dword_AF8C00[(unsigned __int8)(v129 ^ v67 ^ *(BYTE*)(v8 + 80))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v129 ^ v67 ^ *(WORD*)(v8 + 80)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v129 ^ (unsigned int)v67 ^ *(DWORD*)(v8 + 80)) >> 16)] ^ dword_AF9800[(v129 ^ (unsigned int)v67 ^ *(DWORD*)(v8 + 80)) >> 24];
	unsigned int v69 = v68 + v67;
	unsigned int v70 = dword_AF8C00[(unsigned __int8)v69] ^ dword_AF9000[BYTE1(v69)] ^ dword_AF9400[(unsigned __int8)(v69 >> 16)] ^ dword_AF9800[v69 >> 24];
	unsigned int v71 = dword_AF8C00[(unsigned __int8)(v70 + v68)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v70 + v68) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v70 + v68) >> 16)] ^ dword_AF9800[(unsigned int)(v70 + v68) >> 24];
	unsigned int v72 = v71 ^ v60;
	unsigned int v73 = (v71 + v70) ^ v59;
	unsigned int v74 = v73 ^ *(DWORD*)(v8 + 68);
	unsigned int v75 = dword_AF8C00[(unsigned __int8)(v72 ^ v74 ^ *(BYTE*)(v8 + 72))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v72 ^ v74 ^ *(WORD*)(v8 + 72)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v72 ^ (unsigned int)v74 ^ *(DWORD*)(v8 + 72)) >> 16)] ^ dword_AF9800[(v72 ^ (unsigned int)v74 ^ *(DWORD*)(v8 + 72)) >> 24];
	unsigned int v76 = v75 + v74;
	unsigned int v77 = dword_AF8C00[(unsigned __int8)v76] ^ dword_AF9000[BYTE1(v76)] ^ dword_AF9400[(unsigned __int8)(v76 >> 16)] ^ dword_AF9800[v76 >> 24];
	unsigned int v78 = dword_AF8C00[(unsigned __int8)(v77 + v75)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v77 + v75) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v77 + v75) >> 16)] ^ dword_AF9800[(unsigned int)(v77 + v75) >> 24];
	unsigned int v130 = v78 ^ v129;
	unsigned int v79 = (v78 + v77) ^ v66;
	unsigned int v80 = v79 ^ *(DWORD*)(v8 + 60);
	unsigned int v81 = dword_AF8C00[(unsigned __int8)(v130 ^ v80 ^ *(BYTE*)(v8 + 64))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v130 ^ v80 ^ *(WORD*)(v8 + 64)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v130 ^ (unsigned int)v80 ^ *(DWORD*)(v8 + 64)) >> 16)] ^ dword_AF9800[(v130 ^ (unsigned int)v80 ^ *(DWORD*)(v8 + 64)) >> 24];
	unsigned int v82 = v81 + v80;
	unsigned int v83 = dword_AF8C00[(unsigned __int8)v82] ^ dword_AF9000[BYTE1(v82)] ^ dword_AF9400[(unsigned __int8)(v82 >> 16)] ^ dword_AF9800[v82 >> 24];
	unsigned int v84 = dword_AF8C00[(unsigned __int8)(v83 + v81)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v83 + v81) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v83 + v81) >> 16)] ^ dword_AF9800[(unsigned int)(v83 + v81) >> 24];
	unsigned int v85 = v84 ^ v72;
	unsigned int v86 = (v84 + v83) ^ v73;
	unsigned int v87 = v86 ^ *(DWORD*)(v8 + 52);
	unsigned int v88 = dword_AF8C00[(unsigned __int8)(v85 ^ v87 ^ *(BYTE*)(v8 + 56))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v85 ^ v87 ^ *(WORD*)(v8 + 56)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v85 ^ (unsigned int)v87 ^ *(DWORD*)(v8 + 56)) >> 16)] ^ dword_AF9800[(v85 ^ (unsigned int)v87 ^ *(DWORD*)(v8 + 56)) >> 24];
	unsigned int v89 = v88 + v87;
	unsigned int v90 = dword_AF8C00[(unsigned __int8)v89] ^ dword_AF9000[BYTE1(v89)] ^ dword_AF9400[(unsigned __int8)(v89 >> 16)] ^ dword_AF9800[v89 >> 24];
	unsigned int v91 = dword_AF8C00[(unsigned __int8)(v90 + v88)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v90 + v88) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v90 + v88) >> 16)] ^ dword_AF9800[(unsigned int)(v90 + v88) >> 24];
	unsigned int v131 = v91 ^ v130;
	unsigned int v92 = (v91 + v90) ^ v79;
	unsigned int v93 = v92 ^ *(DWORD*)(v8 + 44);
	unsigned int v94 = dword_AF8C00[(unsigned __int8)(v131 ^ v93 ^ *(BYTE*)(v8 + 48))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v131 ^ v93 ^ *(WORD*)(v8 + 48)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v131 ^ (unsigned int)v93 ^ *(DWORD*)(v8 + 48)) >> 16)] ^ dword_AF9800[(v131 ^ (unsigned int)v93 ^ *(DWORD*)(v8 + 48)) >> 24];
	unsigned int v95 = v94 + v93;
	unsigned int v96 = dword_AF8C00[(unsigned __int8)v95] ^ dword_AF9000[BYTE1(v95)] ^ dword_AF9400[(unsigned __int8)(v95 >> 16)] ^ dword_AF9800[v95 >> 24];
	unsigned int v97 = dword_AF8C00[(unsigned __int8)(v96 + v94)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v96 + v94) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v96 + v94) >> 16)] ^ dword_AF9800[(unsigned int)(v96 + v94) >> 24];
	unsigned int v98 = v97 ^ v85;
	unsigned int v99 = (v97 + v96) ^ v86;
	unsigned int v100 = v99 ^ *(DWORD*)(v8 + 36);
	unsigned int v101 = dword_AF8C00[(unsigned __int8)(v98 ^ v100 ^ *(BYTE*)(v8 + 40))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v98 ^ v100 ^ *(WORD*)(v8 + 40)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v98 ^ (unsigned int)v100 ^ *(DWORD*)(v8 + 40)) >> 16)] ^ dword_AF9800[(v98 ^ (unsigned int)v100 ^ *(DWORD*)(v8 + 40)) >> 24];
	unsigned int v102 = v101 + v100;
	unsigned int v103 = dword_AF8C00[(unsigned __int8)v102] ^ dword_AF9000[BYTE1(v102)] ^ dword_AF9400[(unsigned __int8)(v102 >> 16)] ^ dword_AF9800[v102 >> 24];
	unsigned int v104 = dword_AF8C00[(unsigned __int8)(v103 + v101)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v103 + v101) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v103 + v101) >> 16)] ^ dword_AF9800[(unsigned int)(v103 + v101) >> 24];
	unsigned int v132 = v104 ^ v131;
	unsigned int v105 = (v104 + v103) ^ v92;
	unsigned int v106 = v105 ^ *(DWORD*)(v8 + 28);
	unsigned int v107 = dword_AF8C00[(unsigned __int8)(v132 ^ v106 ^ *(BYTE*)(v8 + 32))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v132 ^ v106 ^ *(WORD*)(v8 + 32)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v132 ^ (unsigned int)v106 ^ *(DWORD*)(v8 + 32)) >> 16)] ^ dword_AF9800[(v132 ^ (unsigned int)v106 ^ *(DWORD*)(v8 + 32)) >> 24];
	unsigned int v108 = v107 + v106;
	unsigned int v109 = dword_AF8C00[(unsigned __int8)v108] ^ dword_AF9000[BYTE1(v108)] ^ dword_AF9400[(unsigned __int8)(v108 >> 16)] ^ dword_AF9800[v108 >> 24];
	unsigned int v110 = dword_AF8C00[(unsigned __int8)(v109 + v107)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v109 + v107) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v109 + v107) >> 16)] ^ dword_AF9800[(unsigned int)(v109 + v107) >> 24];
	unsigned int v111 = v110 ^ v98;
	unsigned int v112 = (v110 + v109) ^ v99;
	unsigned int v113 = v112 ^ *(DWORD*)(v8 + 20);
	unsigned int v114 = dword_AF8C00[(unsigned __int8)(v111 ^ v113 ^ *(BYTE*)(v8 + 24))] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v111 ^ v113 ^ *(WORD*)(v8 + 24)) >> 8)] ^ dword_AF9400[(unsigned __int8)((v111 ^ (unsigned int)v113 ^ *(DWORD*)(v8 + 24)) >> 16)] ^ dword_AF9800[(v111 ^ (unsigned int)v113 ^ *(DWORD*)(v8 + 24)) >> 24];
	unsigned int v115 = v114 + v113;
	unsigned int v116 = dword_AF8C00[(unsigned __int8)v115] ^ dword_AF9000[BYTE1(v115)] ^ dword_AF9400[(unsigned __int8)(v115 >> 16)] ^ dword_AF9800[v115 >> 24];
	unsigned int v117 = dword_AF8C00[(unsigned __int8)(v116 + v114)] ^ dword_AF9000[(unsigned __int8)((unsigned __int16)(v116 + v114) >> 8)] ^ dword_AF9400[(unsigned __int8)((unsigned int)(v116 + v114) >> 16)] ^ dword_AF9800[(unsigned int)(v116 + v114) >> 24];
	unsigned int v118 = (v117 + v116) ^ v105;
	unsigned int v119 = v118;
	v118 = __ROL4__(v118, 8);
	v119 = __ROR4__(v119, 8);
	*(DWORD*)pBuff = v118 & 0xFF00FF | v119 & 0xFF00FF00;
	unsigned int v120 = __ROR4__(v117 ^ v132, 8);
	unsigned int v121 = __ROL4__(v117 ^ v132, 8);
	*(DWORD*)(pBuff + 4) = v121 & 0xFF00FF | v120 & 0xFF00FF00;
	unsigned int v122 = __ROR4__(v112, 8);
	v112 = __ROL4__(v112, 8);
	*(DWORD*)(pBuff + 8) = v112 & 0xFF00FF | v122 & 0xFF00FF00;
	unsigned int v123 = v111;
	v111 = __ROL4__(v111, 8);
	v123 = __ROR4__(v123, 8);
	unsigned int result = v111 & 0xFF00FF | v123 & 0xFF00FF00;
	*(DWORD*)(pBuff + 0xC) = result;
	return result;
}

// decrypts the given data buffer via seed
BOOL DecryptData(PDWORD pData, DWORD dwSize, PDWORD pBuff)
{
	// validates the arguments
	if (pData && pBuff)
	{
		// stores the key
		DWORD* pOwKey = (DWORD*)FirstDecryptionBlock;
		// validates the data (that it has atleast 16 blocks)
		if (dwSize >= 16)
		{
			// iterates through the 16 byte blocks
			for (DWORD dwBlocks = dwSize / 16; dwBlocks != 0; dwBlocks--)
			{
				// decrypts the blocks
				DecryptBlock((PBYTE)DecryptionKey, (PBYTE)pData, (PBYTE)pBuff);
				// xors with the key
				pBuff[0] ^= pOwKey[0];
				pBuff[1] ^= pOwKey[1];
				pBuff[2] ^= pOwKey[2];
				pBuff[3] ^= pOwKey[3];
				// sets the ow key pointer as a pointer to the new key
				pOwKey = pData;
				// gets the next block
				pData += 4;
				// gets the next block
				pBuff += 4;
			}
		}
		// function succeeded
		return TRUE;
	}
	// function failed
	return FALSE;
}

// opens the specified package
PVOID Open(LPCSTR lpPackage)
{
	// opens the requested package
	HANDLE hFile = CreateFileA(lpPackage, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
	// validates the handle
	if (hFile != INVALID_HANDLE_VALUE)
	{
		// gets the package size
		DWORD dwSize = GetFileSize(hFile, NULL);
		// validates the package size
		if (dwSize != INVALID_FILE_SIZE)
		{
			// creates a buffer for the file
			PVOID pBuffer = VirtualAlloc(NULL, dwSize, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
			// validates the buffer
			if (pBuffer)
			{
				// stores the number of bytes read
				DWORD dwBytes;
				// reads the package into the buffer
				if (ReadFile(hFile, pBuffer, dwSize, &dwBytes, NULL) && dwBytes == dwSize)
				{
					// closes the file
					if (CloseHandle(hFile))
					{
						// returns the buffer
						return pBuffer;
					}
				}
				// releases the buffer
				VirtualFree(pBuffer, 0, MEM_RELEASE);
			}
		}
		// closes the file
		CloseHandle(hFile);
	}
	// function failed
	return NULL;
}

// the program entry point
int main()
{
	// opens a package
	if (PVOID pPackage = Open("D:\\Games\\AeriaGames\\Ironsight\\data\\script.wpg"))
	{
		// gets the headers
		PPACKAGE_HEADER pHeader = (PPACKAGE_HEADER)pPackage;
		// gets the section array
		PPACKAGE_SECTION pSections = (PPACKAGE_SECTION)(pHeader + 1);
		// iterates through sections
		for (int i = 0; i < pHeader->NumberOfSections; i++)
		{
			cout << pSections[i].FileName << endl;
			// gets the file address
			PVOID pFile = ((PBYTE)pPackage + pSections[i].DataOffset);
			// creates a buffer to store the decrypted data
			if (PBYTE pResult = (PBYTE)malloc(*(DWORD*)pFile + 0x10))
			{
				// notifies the user
				cout << "[+] Buffer Created." << endl;
				// attempts to decrypt the given file
				if (DecryptData((PDWORD)((PBYTE)pFile + 4), pSections[i].DataSize - 4, (PDWORD)pResult))
				{
					// creates a buffer
					PBYTE pUncompressed = (PBYTE)malloc(*(DWORD*)pResult);
					// uncompresses the file
					if (uncompress(pUncompressed, (DWORD*)pResult, &pResult[4], (*(DWORD*)pFile + 0x10) - 4) == Z_OK)
					{
						// notifies the user
						cout << "[+] File Decrypted." << endl;
						// creates a file to write the decrypted file to
						HANDLE hFile = CreateFile(pSections[i].FileName, GENERIC_WRITE, 0, NULL, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, NULL);
						// validates the handle
						if (hFile != INVALID_HANDLE_VALUE)
						{
							// notifies the user
							cout << "[+] File Created." << endl;
							// stores the number of bytes written
							DWORD dwBytes;
							// writes the decrypted data to the file
							if (WriteFile(hFile, pUncompressed, *(DWORD*)pResult, &dwBytes, NULL))
							{
								// notifies the user
								cout << "[+] Successfully Decrypted File." << endl;
								// prints the first 16 bytes of the decrypted data
								for (int i = 0; i < 16; i++) cout << "0x" << hex << (int)pUncompressed[i] << ", ";
							}
						}
					}
				}
			}
		}
	}
	cout << "[-] " << GetLastError() << endl;
	// waits to exit
	cin.get();
	// exits the program
	return 0;
}