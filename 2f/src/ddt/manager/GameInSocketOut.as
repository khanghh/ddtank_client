package ddt.manager
{
   import cardCollectAward.data.AnswerInfo;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import road7th.comm.ByteSocket;
   import road7th.comm.PackageOut;
   import sanXiao.model.SXCellData;
   
   public class GameInSocketOut
   {
      
      private static var _socket:ByteSocket = SocketManager.Instance.socket;
       
      
      public function GameInSocketOut(){super();}
      
      public static function sendGodOfWealthPay() : void{}
      
      public static function sendGodOfWealthInfo() : void{}
      
      public static function sendSXCreateMap(param1:Array) : void{}
      
      public static function sendSXRequireMapInfo() : void{}
      
      public static function sendSXPropCrossBomb(param1:Boolean, param2:int) : void{}
      
      public static function sendSXPropSquareBomb(param1:Boolean, param2:int) : void{}
      
      public static function sendSXPropClearColor(param1:Boolean, param2:int) : void{}
      
      public static function sendSXPropChangeColor(param1:Boolean, param2:int, param3:int, param4:int) : void{}
      
      public static function sendSXBoom(param1:int, param2:int, param3:int, param4:int, param5:Array) : void{}
      
      public static function sendSXFillCellList(param1:Vector.<SXCellData>) : void{}
      
      public static function sendSXRequireViewData() : void{}
      
      public static function sendSXGainPrise(param1:int) : void{}
      
      public static function sendSXBuyItem(param1:int, param2:int) : void{}
      
      public static function sendSXHitsEnd() : void{}
      
      public static function sendSXBuyOneTimes(param1:int, param2:Boolean) : void{}
      
      public static function sendSXRewardsData() : void{}
      
      public static function sendSXStoreData() : void{}
      
      public static function sendGradeBuy(param1:int, param2:int) : void{}
      
      public static function sendEvolutionMaterials(param1:Array) : void{}
      
      public static function sendIsMaster() : void{}
      
      public static function sendDdtKingLetterCompose() : void{}
      
      public static function sendBringUpLockStatusUpdate(param1:int, param2:int, param3:Boolean) : void{}
      
      public static function sendBringUpEat(param1:int, ... rest) : void{}
      
      public static function sendUseGirlNewPhoto(param1:Boolean) : void{}
      
      public static function sendUseGirlPhoto(param1:Boolean) : void{}
      
      public static function sendRedPkgGain(param1:int) : void{}
      
      public static function sendRedPkgSend(param1:int, param2:int, param3:String, param4:Boolean) : void{}
      
      public static function sendRedPkgSendRecord() : void{}
      
      public static function sendRedPkgGainRecord(param1:int) : void{}
      
      public static function sendRequestEnterPyramidSystem() : void{}
      
      public static function sendPyramidTurnCard(param1:int, param2:int, param3:Boolean) : void{}
      
      public static function sendPyramidStartOrstop(param1:Boolean) : void{}
      
      public static function sendPyramidRevive(param1:Boolean, param2:Boolean) : void{}
      
      public static function sendLanternIsOpen() : void{}
      
      public static function sendLanternRequireData() : void{}
      
      public static function sendLanternMakeLantern(param1:int) : void{}
      
      public static function sendLanternCookLantern(param1:int) : void{}
      
      public static function sendLanternWish(param1:int) : void{}
      
      public static function sendLanternGainWishGift() : void{}
      
      public static function sendMaxBtnState(param1:Boolean) : void{}
      
      public static function sendRequireMaxBtnState() : void{}
      
      public static function sendWorshipTheMoon(param1:int, param2:Boolean) : void{}
      
      public static function sendWorshipTheMoonIsActivityOpen() : void{}
      
      public static function sendBagLockStates(param1:ByteArray = null) : void{}
      
      public static function sendWorshipTheMoonFreeCount() : void{}
      
      public static function sendWorshipTheMoonAwardsList() : void{}
      
      public static function sendGainThe200timesAwardBox() : void{}
      
      public static function sendGypsyBuy(param1:int, param2:Boolean) : void{}
      
      public static function sendGypsyRefreshItemList() : void{}
      
      public static function sendGypsyManualRefreshItemList() : void{}
      
      public static function sendGypsyManualRefreshItemListWithRMB(param1:Boolean) : void{}
      
      public static function sendGypsyRefreshRareList() : void{}
      
      public static function sendRequestGypsyNPCState() : void{}
      
      public static function sendGetScenePlayer(param1:int) : void{}
      
      public static function sendInviteGame(param1:int) : void{}
      
      public static function sendBuyProp(param1:int) : void{}
      
      public static function sendSellProp(param1:int, param2:int) : void{}
      
      public static function sendGameRoomSetUp(param1:int, param2:int, param3:Boolean = false, param4:String = "", param5:String = "", param6:int = 2, param7:int = 0, param8:int = 0, param9:Boolean = false, param10:int = 0, param11:Boolean = false, param12:int = 0) : void{}
      
      public static function sendCreateRoom(param1:String, param2:int, param3:int = 2, param4:String = "", param5:Boolean = false) : void{}
      
      public static function sendGameRoomPlaceState(param1:int, param2:int, param3:Boolean = false, param4:int = -100) : void{}
      
      public static function sendGameRoomKick(param1:int) : void{}
      
      public static function sendExitScene() : void{}
      
      public static function sendGamePlayerExit() : void{}
      
      public static function sendGameTeam(param1:int) : void{}
      
      public static function sendFlagMode(param1:Boolean) : void{}
      
      public static function sendGameStart() : void{}
      
      public static function sendGameMissionStart(param1:Boolean) : void{}
      
      public static function sendGameMissionPrepare(param1:int, param2:Boolean) : void{}
      
      public static function sendLoadingProgress(param1:Number) : void{}
      
      public static function sendPlayerState(param1:int) : void{}
      
      public static function sendStartOrPreCheckEnergy() : void{}
      
      public static function sendGameCMDBlast(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public static function sendGameCMDChange(param1:int, param2:int, param3:int, param4:int, param5:int) : void{}
      
      public static function sendGameCMDDirection(param1:int) : void{}
      
      public static function sendGameCMDStunt(param1:int = 0) : void{}
      
      public static function sendGameCMDShoot(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public static function sendGameSkipNext(param1:int) : void{}
      
      public static function sendTransmissionGate(param1:Boolean) : void{}
      
      public static function sendGameStartMove(param1:Number, param2:int, param3:int, param4:Number, param5:Boolean, param6:Number) : void{}
      
      public static function sendGameStopMove(param1:int, param2:int, param3:Boolean) : void{}
      
      public static function sendGameTakeOut(param1:int) : void{}
      
      public static function sendBossTakeOut(param1:int) : void{}
      
      public static function sendGetTropToBag(param1:int) : void{}
      
      public static function sendShootTag(param1:Boolean, param2:int = 0) : void{}
      
      public static function sendBeat(param1:Number, param2:Number, param3:Number) : void{}
      
      public static function sendThrowProp(param1:int) : void{}
      
      public static function sendUseProp(param1:int, param2:int, param3:int) : void{}
      
      public static function sendCancelWait() : void{}
      
      public static function sendSingleRoomBegin(param1:int) : void{}
      
      public static function sendGameStyle(param1:int) : void{}
      
      public static function sendGhostTarget(param1:Point) : void{}
      
      public static function sendPaymentTakeCard(param1:int, param2:Boolean = true) : void{}
      
      public static function sendMissionTryAgain(param1:int, param2:Boolean, param3:Boolean = true) : void{}
      
      public static function sendFightLibInfoChange(param1:int, param2:int = -1) : void{}
      
      public static function sendPassStory() : void{}
      
      public static function sendClientScriptStart() : void{}
      
      public static function sendClientScriptEnd() : void{}
      
      public static function sendFightLibAnswer(param1:int, param2:int) : void{}
      
      public static function sendFightLibReanswer() : void{}
      
      public static function sendUpdatePlayStep(param1:String) : void{}
      
      public static function sendGodCardInfoAttribute() : void{}
      
      public static function sendGodCardOpenCard(param1:int, param2:Boolean) : void{}
      
      public static function sendGodCardOperateCard(param1:int, param2:int, param3:int) : void{}
      
      public static function sendGodCardExchange(param1:int, param2:Boolean = false) : void{}
      
      public static function sendGodCardPointAwardAttribute(param1:int) : void{}
      
      public static function sendSelectObject(param1:int, param2:int) : void{}
      
      public static function sendGetActivePveInfo() : void{}
      
      public static function sendMoneyTreeSpeedUp(param1:int, param2:int, param3:Boolean) : void{}
      
      public static function sendMoneyTreeSendRedPackage(param1:Array) : void{}
      
      public static function sendMoneyTreePick(param1:int) : void{}
      
      public static function sendMoneyTreeRequireInfo() : void{}
      
      public static function sendOrdinaryFB(param1:Boolean, param2:Boolean) : void{}
      
      public static function sendKingDivisionGameStart(param1:int) : void{}
      
      public static function sendGetConsortionMessageThisZone() : void{}
      
      public static function sendGetConsortionMessageAllZone() : void{}
      
      public static function sendGetEliminateConsortionMessageThisZone() : void{}
      
      public static function sendGetEliminateConsortionMessageAllZone() : void{}
      
      public static function sendDiceRefreshData() : void{}
      
      public static function sendStartDiceInfo(param1:int, param2:int) : void{}
      
      public static function sendRequestEnterDiceSystem() : void{}
      
      public static function sendGetBattleSkillInfo() : void{}
      
      public static function sendUpdateBattleSkill(param1:int) : void{}
      
      public static function sendBringBattleSkill(param1:int, param2:int) : void{}
      
      public static function sendGetFriendPack(param1:String, param2:String, param3:int, param4:int) : void{}
      
      public static function sendQuestionAnswer(param1:AnswerInfo) : void{}
      
      public static function sendGoldmineInfoAttribute() : void{}
      
      public static function sendGoldmineUse() : void{}
      
      public static function sendChangeRoomHost(param1:int) : void{}
      
      private static function sendPackage(param1:PackageOut) : void{}
      
      public static function sendCalendarPet() : void{}
   }
}
