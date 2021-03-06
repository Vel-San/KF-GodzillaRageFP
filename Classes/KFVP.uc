Class KFVP extends Interaction;

const VoicePackageName="KF_VP";
var bool bSiren, bScrake, bFleshP, bPatty, bBloat, bClot, bCrawler, bGib, bDecap;

struct SoundGroupStruct
{
	var SoundGroup S;
	var array<Sound> L;
};

var array<SoundGroupStruct> Cache;

function Initialized()
{
	local SoundGroup S;

	// Siren - Demon Screech
	if (bSiren){
		MutLog("-----|| Siren Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd_CIRCUS.Siren_AttackScream');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("Siren_Demon_Scream");
	}

	// Clot - Roblox Oof
	if (bClot){
		MutLog("-----|| Clot Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd.Clot_Death');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("ClotDeath");
	}

	// Crawler
	if (bCrawler){
		MutLog("-----|| Crawler Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd.Crawler_Death');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("CrawlerDeath");
	}

	// ZED Gib Sound - Remove Sound
	if (bGib){
		MutLog("-----|| Gib Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemyGlobalSnd.Zomb_HeadlessDie');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("NoSound");
	}

	// ZED Decap - Pop Sound
	if (bDecap){
		MutLog("-----|| Decap Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemyGlobalSnd.Generic_Decap');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("DecapPop");
	}

	// Scrake - Chaac BloodBath SMITE
	if (bScrake){
		MutLog("-----|| Scrake Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd.Scrake_Attack');
		S.Sounds.Length = 4;
		S.Sounds[0] = LoadSound("ScrakeAttack1");
		S.Sounds[1] = LoadSound("ScrakeAttack2");
		S.Sounds[2] = LoadSound("ScrakeAttack3");
		S.Sounds[3] = LoadSound("ScrakeAttack4");
	}

	// FleshPound - Godzilla
	if (bFleshP){
		MutLog("-----|| Fleshpound Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd_CIRCUS.FP_Rage');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("FP_godzilla_rage");
	}

	// Bloat - L4D2 Explosion
	if (bBloat){
		MutLog("-----|| Bloat Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd_HALLOWEEN.Bloat_DeathPop');
		S.Sounds.Length = 3;
		S.Sounds[0] = LoadSound("BoomerPop1");
		S.Sounds[1] = LoadSound("BoomerPop2");
		S.Sounds[2] = LoadSound("BoomerPop3");
	}

	// Patty - John Cena
	if (bPatty){
		MutLog("-----|| Patty Custom Sound Enabled ||-----");
		CacheSound(S,SoundGroup'KF_EnemiesFinalSnd.Kev_Entrance');
		S.Sounds.Length = 1;
		S.Sounds[0] = LoadSound("PattyEntrance1");
	}
}

function NotifyLevelChange()
{
	local int i;

	// Cleanup this mod and reset voices.
	for( i=0; i<Cache.Length; ++i )
		Cache[i].S.Sounds = Cache[i].L;
	Cache.Length = 0;
}

final function CacheSound( out SoundGroup S, SoundGroup In )
{
	local int i;

	S = In;
	i = Cache.Length;
	Cache.Length = i+1;
	Cache[i].S = S;
	Cache[i].L = S.Sounds;
}

final function CacheCopySound( SoundGroup S, SoundGroup Src )
{
	CacheSound(S,S);
	S.Sounds = Src.Sounds;
}
static final function InitializeSoundsFor( PlayerController PC )
{
	local int i;
	local KFVP C;

	if( PC==None )
		return;
	for( i=(PC.Player.LocalInteractions.Length-1); i>=0; --i )
		if( PC.Player.LocalInteractions[i].Class==Default.Class )
			return;
	C = new(None) Class'KFVP';
	C.ViewportOwner = PC.Player;
	C.Master = PC.Player.InteractionMaster;
	i = PC.Player.LocalInteractions.Length;
	PC.Player.LocalInteractions.Length = i+1;
	PC.Player.LocalInteractions[i] = C;
	C.Initialize();
}

static final function string GetVoicePackage()
{
	return VoicePackageName;
}
static final function Sound LoadSound( string N )
{
	return Sound(DynamicLoadObject(VoicePackageName$"."$N,Class'Sound'));
}

simulated function MutLog(string s)
{
    log(s, 'ZedVoiceChanger');
}

defaultproperties
{
	// Bool Vars
	bSiren=True
	bScrake=True
	bFleshP=True
	bPatty=True
	bBloat=True
    bClot=True
	bCrawler=True
	bGib=True
	bDecap=True
}