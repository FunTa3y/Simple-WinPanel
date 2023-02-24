#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public void OnPluginStart(){
HookEvent("round_end", Event_RoundEnd); //Хукаем конец раунда
HookEvent("cs_win_panel_round", Win_Panel_Round, EventHookMode_Pre); //Хукаем показ ориг таблички
}

public Action Event_RoundEnd(Handle event, const char[] name, bool dontBroadcast){
    int winner = GetEventInt(event, "winner"); //Получаем победившую команду
    for (int i = 1; i <= MaxClients; i++) {
    int client = GetClientOfUserId(i);
    if (client > 0) { //Обзначаем всех игроков как client


    char message[30]; //Подготоваливаем сообщение
    if (winner == 2){
    Format(message, sizeof(message), "HIDERS WIN!"); //Терры победили
    SetHudTextParams(-1.0, 0.255, 10.2, 247, 42, 134, 255, 2, 0.25, 0.2, 0.2);//Красный цвет, побуквенная анимация
    }
    else if (winner == 3){
    Format(message, sizeof(message), "SEEKERS WIN!"); //Кт победили
    SetHudTextParams(-1.0, 0.255, 10.2, 42, 165, 247, 255, 2, 0.25, 0.2, 0.2);//Синий цвет, побуквенная анимация
    }
    else{
    Format(message, sizeof(message), "NO WINNERS!"); //Ничья
    SetHudTextParams(-1.0, 0.255, 10.2, 128, 128, 128, 255, 2, 0.25, 0.2, 0.2);//Серый цвет, побуквенная анимация
    }
    ShowHudText(client, 5, message); //Отправляем сообщение в худ
    return Plugin_Continue;
}}}
public Action Win_Panel_Round(Event event, const char[] name, bool dontBroadcast){
	if (!dontBroadcast)
	{
		SetEventBroadcast(event, true); //Скрываем Оригинальную табличку (Если не помогло попробуйте добавить в server.cfg: sm_cvar sv_nowinpanel 1)
	}
	return Plugin_Continue;
}

public Plugin myinfo = 
{
	name = "WinPanel",
	author = "RSq | funtazzy",
	version = "1.3",
};
