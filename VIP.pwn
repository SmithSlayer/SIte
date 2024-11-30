//VIP BY SMITH

#include <a_samp>
#include <DOF2>

#if defined FILTERSCRIPT

enum pInfo
{
	pVip,
	pDias
};


new Player[MAX_PLAYERS][pInfo];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Sistema Vip By Smith");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    if(pInfo[playerid][pVip] > 0 && gettime() >= Player[playerid][pDias])
	{
    SendClientMessage(playerid, -1, "Seu Vip EXPIROU");
    Player[playerid][pVip] = 0;
    Player[playerid][pDias] = 0;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

//COMANDOS VIP//
CMD:darvip(playerid, params[])
{
	new id, nivel, dias;
	if(sscanf(params, "ddd", id, nivel, dias)) return SendClientMessage(playerid, Vermelho, "Use /darvip [id] [nivel] [dias]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Vermelho, "Jogadores Offline");
	if(nivel < 1 || nivel > 3) return SendClientMessage(playerid, Vermelho, "Niveis de VIP de 1 a 3");
	Player[playerid][pVip] = nivel;
	Player[playerid][pDias] = (gettime() + (dias * 24 * 60 * 60));
	new str[150];
	format(str, 150, "O Admin lhe setou %d Dias De %s", dias, GetNomeVip(nivel));
	SendClientMessage(id, -1, str);
	return 1;
}
CMD:equiparvip(playerid)
{
	if(Player[playerid][pVip] == 0) return SendClientMessage(playerid, Vermelho, "Voce nao tem VIP");
	GivePlayerWeapon(playerid, 31, 1231);
	return 1;
}
stock GetNomeVip(nivelvip)
{
	new str[50];
	if(nivelvip == 1)
	{
	    str = "VIP Bronze";
	}
	if(nivelvip == 2)
	{
	    str = "VIP Prata";
	}
	if(nivelvip == 3)
	{
	    str = "VIP Ouro";
	}
	return str;
}

stock SalvarDados(playerid)
{
	DOF2_SetInt(Arquivo(playerid), "Vip", Player[playerid][pVip]);
	DOF2_SetInt(Arquivo(playerid), "DiasVip", Player[playerid][pDias]);
	DOF2_SaveFile();
	return 1;
}
stock CarregarDados(playerid)
{
	Player[playerid][pVip] = DOF2_GetInt(Arquivo(playerid), "Vip");
	Player[playerid][pDias] = DOF2_GetInt(Arquivo(playerid), "DiasVip");
	return 1;
}
stock Arquivo(playerid)
{
	new string[100];
	format(string, 100, "Contas/%s.ini", pName(playerid));
	return string;
}
