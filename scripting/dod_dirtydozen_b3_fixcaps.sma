#include <amxmodx>
#include <engine>
#include <fakemeta>
#include <hamsandwich>

new g_entRadioRelay = -1
new g_entTowerRelay = -1

public plugin_init()
{
	register_plugin("FixCaps dirtydozen_b3", "0.1", "Fysiks")
	
	new szTarget[32], ent = -1
	while( (ent = find_ent_by_class(ent, "dod_point_relay")) )
	{
		pev(ent, pev_target, szTarget, charsmax(szTarget))
		if( equal(szTarget, "radiopoint") )
		{
			g_entRadioRelay = ent
		}
		else if( equal(szTarget, "towerwallpt") )
		{
			g_entTowerRelay = ent
		}
	}
	
	RegisterHam(Ham_Use, "multi_manager", "HamUse_multimanager")
	RegisterHam(Ham_Use, "env_explosion", "HamUse_envexplosion")
}

public HamUse_multimanager(this, idcaller, idactivator, use_type, Float:value)
{
	static szTargetName[32]
	pev(this, pev_targetname, szTargetName, charsmax(szTargetName))
	// client_print(0, print_chat, "MultiManger: %s triggered (%d)", szTargetName, this)
	if( equal(szTargetName, "count1") )
		set_task(5.0, "forceCapRadio", this)
}

public HamUse_envexplosion(this, idcaller, idactivator, use_type, Float:value)
{
	static szTargetName[32]
	pev(this, pev_targetname, szTargetName, charsmax(szTargetName))
	// client_print(0, print_chat, "env_explosion: %s (%d) Activator: %d Caller: %d", szTargetName, this, idactivator, idcaller)
	if( equal(szTargetName, "towerwall") )
		forceCapTower(idactivator)
}

forceCapTower(ent)
{
	ExecuteHamB(Ham_Use, g_entTowerRelay, ent, ent, 3, 0.0)
}

public forceCapRadio(ent)
{
	ExecuteHamB(Ham_Use, g_entRadioRelay, ent, ent, 1, 0.0)
}
