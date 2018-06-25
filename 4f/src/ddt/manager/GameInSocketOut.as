package ddt.manager{   import cardCollectAward.data.AnswerInfo;   import flash.geom.Point;   import flash.utils.ByteArray;   import road7th.comm.ByteSocket;   import road7th.comm.PackageOut;   import sanXiao.model.SXCellData;      public class GameInSocketOut   {            private static var _socket:ByteSocket = SocketManager.Instance.socket;                   public function GameInSocketOut() { super(); }
            public static function sendGodOfWealthPay() : void { }
            public static function sendGodOfWealthInfo() : void { }
            public static function sendSXCreateMap(map:Array) : void { }
            public static function sendSXRequireMapInfo() : void { }
            public static function sendSXPropCrossBomb(isBind:Boolean, needMoney:int) : void { }
            public static function sendSXPropSquareBomb(isBind:Boolean, needMoney:int) : void { }
            public static function sendSXPropClearColor(isBind:Boolean, needMoney:int) : void { }
            public static function sendSXPropChangeColor(isBind:Boolean, needMoney:int, originalType:int, changeToType:int) : void { }
            public static function sendSXBoom(rowA:int, columnA:int, rowB:int, columnB:int, boomList:Array) : void { }
            public static function sendSXFillCellList($list:Vector.<SXCellData>) : void { }
            public static function sendSXRequireViewData() : void { }
            public static function sendSXGainPrise(id:int) : void { }
            public static function sendSXBuyItem(id:int, num:int) : void { }
            public static function sendSXHitsEnd() : void { }
            public static function sendSXBuyOneTimes(times:int, isBind:Boolean) : void { }
            public static function sendSXRewardsData() : void { }
            public static function sendSXStoreData() : void { }
            public static function sendGradeBuy(typeTempleteID:int, giftTempleteID:int) : void { }
            public static function sendEvolutionMaterials(arr:Array) : void { }
            public static function sendIsMaster() : void { }
            public static function sendDdtKingLetterCompose() : void { }
            public static function sendBringUpLockStatusUpdate(bagType:int, place:int, isLocked:Boolean) : void { }
            public static function sendBringUpEat(count:int, ... arg) : void { }
            public static function sendUseGirlNewPhoto($isBind:Boolean) : void { }
            public static function sendUseGirlPhoto(isUse:Boolean) : void { }
            public static function sendRedPkgGain(id:int) : void { }
            public static function sendRedPkgSend(moneyNum:int, pkgNum:int, wishWords:String, isAverage:Boolean) : void { }
            public static function sendRedPkgSendRecord() : void { }
            public static function sendRedPkgGainRecord(id:int) : void { }
            public static function sendRequestEnterPyramidSystem() : void { }
            public static function sendPyramidTurnCard(layer:int, position:int, bindFlag:Boolean) : void { }
            public static function sendPyramidStartOrstop(isStart:Boolean) : void { }
            public static function sendPyramidRevive(isRevive:Boolean, bindFlag:Boolean) : void { }
            public static function sendLanternIsOpen() : void { }
            public static function sendLanternRequireData() : void { }
            public static function sendLanternMakeLantern(num:int) : void { }
            public static function sendLanternCookLantern(num:int) : void { }
            public static function sendLanternWish(id:int) : void { }
            public static function sendLanternGainWishGift() : void { }
            public static function sendMaxBtnState(isPackUp:Boolean) : void { }
            public static function sendRequireMaxBtnState() : void { }
            public static function sendWorshipTheMoon(counts:int, isBindTickets:Boolean) : void { }
            public static function sendWorshipTheMoonIsActivityOpen() : void { }
            public static function sendBagLockStates(stateData:ByteArray = null) : void { }
            public static function sendWorshipTheMoonFreeCount() : void { }
            public static function sendWorshipTheMoonAwardsList() : void { }
            public static function sendGainThe200timesAwardBox() : void { }
            public static function sendGypsyBuy(id:int, isBind:Boolean) : void { }
            public static function sendGypsyRefreshItemList() : void { }
            public static function sendGypsyManualRefreshItemList() : void { }
            public static function sendGypsyManualRefreshItemListWithRMB(isBind:Boolean) : void { }
            public static function sendGypsyRefreshRareList() : void { }
            public static function sendRequestGypsyNPCState() : void { }
            public static function sendGetScenePlayer(index:int) : void { }
            public static function sendInviteGame(playerid:int) : void { }
            public static function sendBuyProp(id:int) : void { }
            public static function sendSellProp(id:int, GoodsID:int) : void { }
            public static function sendGameRoomSetUp(id:int, type:int, isOpenBoss:Boolean = false, pass:String = "", name:String = "", secondType:int = 2, permission:int = 0, levelLimits:int = 0, allowCrossZone:Boolean = false, tempID:int = 0, isBand:Boolean = false, gameType:int = 0) : void { }
            public static function sendCreateRoom(name:String, roomType:int, timeType:int = 2, pass:String = "", isDouble:Boolean = false) : void { }
            public static function sendGameRoomPlaceState(index:int, isOpened:int, toNewPlace:Boolean = false, _newPlace:int = -100) : void { }
            public static function sendGameRoomKick(index:int) : void { }
            public static function sendExitScene() : void { }
            public static function sendGamePlayerExit() : void { }
            public static function sendGameTeam(team:int) : void { }
            public static function sendFlagMode(flag:Boolean) : void { }
            public static function sendGameStart() : void { }
            public static function sendGameMissionStart(isStart:Boolean) : void { }
            public static function sendGameMissionPrepare(place:int, isRead:Boolean) : void { }
            public static function sendLoadingProgress(progress:Number) : void { }
            public static function sendPlayerState(ready:int) : void { }
            public static function sendStartOrPreCheckEnergy() : void { }
            public static function sendGameCMDBlast(id:int, x:int, y:int, t:int) : void { }
            public static function sendGameCMDChange(id:int, bombPosX:int, bombPosY:int, vx:int, vy:int) : void { }
            public static function sendGameCMDDirection(direction:int) : void { }
            public static function sendGameCMDStunt(skillId:int = 0) : void { }
            public static function sendGameCMDShoot(x:int, y:int, force:int, angle:int) : void { }
            public static function sendGameSkipNext(time:int) : void { }
            public static function sendTransmissionGate(value:Boolean) : void { }
            public static function sendGameStartMove(type:Number, x:int, y:int, dir:Number, isLiving:Boolean, turnIndex:Number) : void { }
            public static function sendGameStopMove(posX:int, posY:int, isUser:Boolean) : void { }
            public static function sendGameTakeOut(place:int) : void { }
            public static function sendBossTakeOut(place:int) : void { }
            public static function sendGetTropToBag(place:int) : void { }
            public static function sendShootTag(b:Boolean, time:int = 0) : void { }
            public static function sendBeat(x:Number, y:Number, angle:Number) : void { }
            public static function sendThrowProp(place:int) : void { }
            public static function sendUseProp(type:int, place:int, tempid:int) : void { }
            public static function sendCancelWait() : void { }
            public static function sendSingleRoomBegin(type:int) : void { }
            public static function sendGameStyle(style:int) : void { }
            public static function sendGhostTarget(pos:Point) : void { }
            public static function sendPaymentTakeCard(place:int, bool:Boolean = true) : void { }
            public static function sendMissionTryAgain(tryAgain:int, isHost:Boolean, bool:Boolean = true) : void { }
            public static function sendFightLibInfoChange(id:int, difficult:int = -1) : void { }
            public static function sendPassStory() : void { }
            public static function sendClientScriptStart() : void { }
            public static function sendClientScriptEnd() : void { }
            public static function sendFightLibAnswer(questionID:int, answerID:int) : void { }
            public static function sendFightLibReanswer() : void { }
            public static function sendUpdatePlayStep(cmd:String) : void { }
            public static function sendGodCardInfoAttribute() : void { }
            public static function sendGodCardOpenCard(type:int, isBind:Boolean) : void { }
            public static function sendGodCardOperateCard(type:int, id:int, count:int) : void { }
            public static function sendGodCardExchange(id:int, useGodCard:Boolean = false) : void { }
            public static function sendGodCardPointAwardAttribute(id:int) : void { }
            public static function sendSelectObject(id:int, zoneID:int) : void { }
            public static function sendGetActivePveInfo() : void { }
            public static function sendMoneyTreeSpeedUp(position:int, times:int, bind:Boolean) : void { }
            public static function sendMoneyTreeSendRedPackage(sendList:Array) : void { }
            public static function sendMoneyTreePick(position:int) : void { }
            public static function sendMoneyTreeRequireInfo() : void { }
            public static function sendOrdinaryFB(flag:Boolean, double:Boolean) : void { }
            public static function sendKingDivisionGameStart(type:int) : void { }
            public static function sendGetConsortionMessageThisZone() : void { }
            public static function sendGetConsortionMessageAllZone() : void { }
            public static function sendGetEliminateConsortionMessageThisZone() : void { }
            public static function sendGetEliminateConsortionMessageAllZone() : void { }
            public static function sendDiceRefreshData() : void { }
            public static function sendStartDiceInfo(type:int, position:int) : void { }
            public static function sendRequestEnterDiceSystem() : void { }
            public static function sendGetBattleSkillInfo() : void { }
            public static function sendUpdateBattleSkill(skillId:int) : void { }
            public static function sendBringBattleSkill(skillID:int, skillPlace:int) : void { }
            public static function sendGetFriendPack(name:String, content:String, bagType:int, place:int) : void { }
            public static function sendQuestionAnswer(info:AnswerInfo) : void { }
            public static function sendGoldmineInfoAttribute() : void { }
            public static function sendGoldmineUse() : void { }
            public static function sendChangeRoomHost(roomHostID:int) : void { }
            private static function sendPackage(pkg:PackageOut) : void { }
            public static function sendCalendarPet() : void { }
   }}