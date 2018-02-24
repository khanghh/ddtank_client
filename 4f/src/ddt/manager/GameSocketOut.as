package ddt.manager
{
   import Indiana.IndianaEPackageType;
   import baglocked.BaglockedManager;
   import cloudBuyLottery.model.CloudBuyLotteryPackageType;
   import ddt.data.AccountInfo;
   import ddt.data.SendGoodsExchangeInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.events.CEvent;
   import ddt.utils.CrytoUtils;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import foodActivity.event.FoodActivityEvent;
   import gemstone.info.GemstnoeSendInfo;
   import horseRace.controller.HorseRaceManager;
   import road7th.comm.ByteSocket;
   import road7th.comm.PackageOut;
   import road7th.math.randRange;
   import trainer.controller.WeakGuildManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import worldBossHelper.data.WorldBossHelperTypeData;
   
   public class GameSocketOut
   {
       
      
      private var _socket:ByteSocket;
      
      public function GameSocketOut(param1:ByteSocket){super();}
      
      public function sendLogin(param1:AccountInfo, param2:Boolean) : void{}
      
      public function sendWeeklyClick() : void{}
      
      public function sendLoginDebug() : void{}
      
      public function sendRandomSuitUse(param1:int, param2:Boolean) : void{}
      
      public function sendGameLogin(param1:int, param2:int, param3:int = -1, param4:String = "", param5:Boolean = false) : void{}
      
      public function sendRefreshServer() : void{}
      
      public function sendReconnection() : void{}
      
      public function sendFastInviteCall() : void{}
      
      public function sendSceneLogin(param1:int) : void{}
      
      public function sendGameStyle(param1:int) : void{}
      
      public function sendDailyAward(param1:int) : void{}
      
      public function sendRestroDaily(param1:Date) : void{}
      
      public function sendSignAward(param1:int) : void{}
      
      public function sendBuyGoods(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array = null, param7:int = 0, param8:Array = null, param9:Array = null) : void{}
      
      public function sendNewBuyGoods(param1:int, param2:int, param3:int = 1, param4:String = "", param5:int = 0, param6:Boolean = false, param7:String = "", param8:int = 0, param9:int = 1, param10:Boolean = true) : void{}
      
      public function sendBuyProp(param1:int, param2:Boolean) : void{}
      
      public function sendSellProp(param1:int, param2:int) : void{}
      
      public function sendQuickBuyGoldBox(param1:int, param2:Boolean) : void{}
      
      public function sendBuyGiftBag(param1:int) : void{}
      
      public function sendButTransnationalGoods(param1:int) : void{}
      
      public function sendPresentGoods(param1:Array, param2:Array, param3:Array, param4:Array, param5:String, param6:String, param7:Array = null, param8:Array = null) : void{}
      
      public function sendGoodsContinue(param1:Array) : void{}
      
      public function sendSellGoods(param1:int) : void{}
      
      public function sendUpdateGoodsCount() : void{}
      
      public function sendEmail(param1:Object) : void{}
      
      public function sendUpdateMail(param1:int) : void{}
      
      public function sendDeleteSentMail(param1:int) : void{}
      
      public function sendDeleteMail(param1:int) : void{}
      
      public function untreadEmail(param1:int) : void{}
      
      public function sendGetMail(param1:int, param2:int) : void{}
      
      public function sendPint() : void{}
      
      public function sendSuicide(param1:int) : void{}
      
      public function sendKillSelf(param1:int) : void{}
      
      public function sendItemCompose(param1:Boolean) : void{}
      
      public function sendItemTransfer(param1:Boolean = true, param2:Boolean = true, param3:int = 12, param4:int = 0, param5:int = 12, param6:int = 1) : void{}
      
      public function sendItemStrength(param1:Boolean, param2:Boolean) : void{}
      
      public function sendItemExalt() : void{}
      
      public function sendExaltRestore() : void{}
      
      public function sendItemLianhua(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int, param7:int) : void{}
      
      public function sendBeadEquip(param1:int, param2:int) : void{}
      
      public function sendBeadUpgrade(param1:Array) : void{}
      
      public function sendOpenBead(param1:int, param2:Boolean) : void{}
      
      public function sendBeadLock(param1:int) : void{}
      
      public function sendBeadOpenHole(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendBeadAdvanceExchange(param1:int, param2:int, param3:int) : void{}
      
      public function sendItemEmbedBackout(param1:int, param2:int) : void{}
      
      public function sendItemOpenFiveSixHole(param1:int, param2:int, param3:int) : void{}
      
      public function sendItemTrend(param1:int, param2:int, param3:int, param4:int, param5:int) : void{}
      
      public function sendClearStoreBag() : void{}
      
      public function sendCheckCode(param1:String) : void{}
      
      public function sendEquipRetrieve() : void{}
      
      public function sendItemFusion(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendSBugle(param1:String) : void{}
      
      public function sendBBugle(param1:String, param2:int) : void{}
      
      public function sendCBugle(param1:String) : void{}
      
      public function sendDefyAffiche(param1:String, param2:Boolean) : void{}
      
      public function sendGameMode(param1:int) : void{}
      
      public function sendAddFriend(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) : void{}
      
      public function sendDelFriend(param1:int) : void{}
      
      public function sendFriendState(param1:int) : void{}
      
      public function sendBagLocked(param1:String, param2:int, param3:String = "", param4:String = "", param5:String = "", param6:String = "", param7:String = "") : void{}
      
      public function sendBagLockedII(param1:String, param2:String, param3:String, param4:String, param5:String) : void{}
      
      public function sendConsortiaEquipConstrol(param1:Array) : void{}
      
      public function sendErrorMsg(param1:String) : void{}
      
      public function sendItemOverDue(param1:int, param2:int) : void{}
      
      public function sendHideLayer(param1:int, param2:Boolean) : void{}
      
      public function sendQuestManuGet(param1:int) : void{}
      
      public function sendQuestAdd(param1:Array) : void{}
      
      public function sendQuestRemove(param1:int) : void{}
      
      public function sendQuestFinish(param1:int, param2:int, param3:int = 0) : void{}
      
      public function sendQuestOneToFinish(param1:int) : void{}
      
      public function sendImproveQuest(param1:int, param2:Boolean) : void{}
      
      public function sendQuestCheck(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendItemOpenUp(param1:int, param2:int, param3:int = 1, param4:Boolean = false) : void{}
      
      public function sendUseLoveFeelingly(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendItemEquip(param1:*, param2:Boolean = false) : void{}
      
      public function sendMateTime(param1:int) : void{}
      
      public function sendPlayerGift(param1:int) : void{}
      
      public function sendActivePullDown(param1:int, param2:String) : void{}
      
      public function auctionGood(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean) : void{}
      
      public function auctionCancelSell(param1:int) : void{}
      
      public function auctionBid(param1:int, param2:int) : void{}
      
      public function syncStep(param1:int, param2:Boolean = true) : void{}
      
      public function syncWeakStep(param1:int) : void{}
      
      public function sendCreateConsortia(param1:String, param2:Boolean) : void{}
      
      public function sendConsortiaTryIn(param1:int) : void{}
      
      public function sendConsortiaCancelTryIn() : void{}
      
      public function sendConsortiaInvate(param1:String) : void{}
      
      public function sendReleaseConsortiaTask(param1:int, param2:Boolean = true, param3:int = 1, param4:int = 0, param5:int = 0, param6:int = 0) : void{}
      
      public function addSpeed(param1:int, param2:int) : void{}
      
      public function sendConsortiaInvatePass(param1:int) : void{}
      
      public function sendConsortiaInvateDelete(param1:int) : void{}
      
      public function sendConsortiaUpdateDescription(param1:String) : void{}
      
      public function sendConsortiaUpdatePlacard(param1:String) : void{}
      
      public function sendConsortiaUpdateDuty(param1:int, param2:String, param3:int) : void{}
      
      public function sendConsortiaUpgradeDuty(param1:int, param2:int) : void{}
      
      public function sendConsoritaApplyStatusOut(param1:Boolean) : void{}
      
      public function sendConsortiaOut(param1:int) : void{}
      
      public function sendConsortiaMemberGrade(param1:int, param2:Boolean) : void{}
      
      public function sendConsortiaUserRemarkUpdate(param1:int, param2:String) : void{}
      
      public function sendConsortiaDutyDelete(param1:int) : void{}
      
      public function sendConsortiaTryinPass(param1:int) : void{}
      
      public function sendConsortiaTryinDelete(param1:int) : void{}
      
      public function sendForbidSpeak(param1:int, param2:Boolean) : void{}
      
      public function sendConsortiaDismiss() : void{}
      
      public function sendConsortiaChangeChairman(param1:String = "") : void{}
      
      public function sendConsortiaRichOffer(param1:int) : void{}
      
      public function sendDonate(param1:int, param2:int) : void{}
      
      public function sendConsortiaLevelUp(param1:int) : void{}
      
      public function sendAirPlane() : void{}
      
      public function useDeputyWeapon() : void{}
      
      public function sendGamePick(param1:int) : void{}
      
      public function sendPetSkill(param1:int, param2:int = 1) : void{}
      
      public function sendPackage(param1:PackageOut) : void{}
      
      public function sendMoveGoods(param1:int, param2:int, param3:int, param4:int, param5:int = 1, param6:Boolean = false) : void{}
      
      public function reclaimGoods(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendMoveGoodsAll(param1:int, param2:Array, param3:int, param4:Boolean = false) : void{}
      
      public function sendForSwitch() : void{}
      
      public function sendCIDCheck() : void{}
      
      public function sendCIDInfo(param1:String, param2:String) : void{}
      
      public function sendChangeColor(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:int) : void{}
      
      public function sendUseCard(param1:int, param2:int, param3:Array, param4:int, param5:Boolean = false, param6:Boolean = true, param7:int = 1) : void{}
      
      public function sendUseProp(param1:int, param2:int, param3:Array, param4:int, param5:Boolean = false) : void{}
      
      public function sendUseChangeColorShell(param1:int, param2:int) : void{}
      
      public function sendChangeColorShellTimeOver(param1:int, param2:int) : void{}
      
      public function sendRouletteBox(param1:int, param2:int, param3:int = -1) : void{}
      
      public function sendStartTurn(param1:int = 1) : void{}
      
      public function sendFinishRoulette() : void{}
      
      public function sendSellAll() : void{}
      
      public function sendconverted(param1:Boolean, param2:int = 0, param3:int = 0) : void{}
      
      public function sendExchange() : void{}
      
      public function sendOpenAll() : void{}
      
      public function sendOpenDead(param1:int, param2:int, param3:int) : void{}
      
      public function sendRequestAwards(param1:int) : void{}
      
      public function sendQequestBadLuck(param1:Boolean = false) : void{}
      
      public function sendQequestLuckky(param1:Boolean = false) : void{}
      
      public function sendUseReworkName(param1:int, param2:int, param3:String) : void{}
      
      public function sendUseConsortiaReworkName(param1:int, param2:int, param3:int, param4:String) : void{}
      
      public function sendValidateMarry(param1:int) : void{}
      
      public function sendPropose(param1:int, param2:String, param3:Boolean, param4:Boolean) : void{}
      
      public function sendProposeRespose(param1:Boolean, param2:int, param3:int) : void{}
      
      public function sendUnmarry(param1:Boolean = false) : void{}
      
      public function sendMarryRoomLogin() : void{}
      
      public function sendExitMarryRoom() : void{}
      
      public function sendCreateRoom(param1:String, param2:String, param3:int, param4:int, param5:Boolean, param6:String, param7:int) : void{}
      
      public function sendEnterRoom(param1:int, param2:String, param3:int = 1) : void{}
      
      public function sendExitRoom() : void{}
      
      public function sendCurrentState(param1:uint) : void{}
      
      public function sendUpdateRoomList(param1:int, param2:int, param3:int = 10000, param4:int = 1013) : void{}
      
      public function sendChurchMove(param1:int, param2:int, param3:String) : void{}
      
      public function sendStartWedding(param1:Boolean = false) : void{}
      
      public function sendChurchContinuation(param1:int) : void{}
      
      public function sendChurchInvite(param1:int) : void{}
      
      public function sendChurchLargess(param1:uint) : void{}
      
      public function refund() : void{}
      
      public function requestRefund() : void{}
      
      public function sendUseFire(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendChurchKick(param1:int) : void{}
      
      public function sendChurchMovieOver(param1:int, param2:String) : void{}
      
      public function sendChurchForbid(param1:int) : void{}
      
      public function sendPosition(param1:Number, param2:Number) : void{}
      
      public function sendModifyChurchDiscription(param1:String, param2:Boolean, param3:String, param4:String) : void{}
      
      public function sendSceneChange(param1:int) : void{}
      
      public function sendGunSalute(param1:int, param2:int) : void{}
      
      public function sendRequestSeniorChurch() : void{}
      
      public function sendRegisterInfo(param1:int, param2:Boolean, param3:String = null) : void{}
      
      public function sendModifyInfo(param1:Boolean, param2:String = null) : void{}
      
      public function sendForMarryInfo(param1:int) : void{}
      
      public function sendGetLinkGoodsInfo(param1:int, param2:String, param3:String = "") : void{}
      
      public function sendGetTropToBag(param1:int) : void{}
      
      public function createUserGuide(param1:int = 10) : void{}
      
      public function enterUserGuide(param1:int, param2:int = 10) : void{}
      
      public function userGuideStart() : void{}
      
      public function sendSaveDB() : void{}
      
      public function createMonster() : void{}
      
      public function deleteMonster() : void{}
      
      public function sendHotSpringEnter() : void{}
      
      public function sendHotSpringRoomCreate(param1:*) : void{}
      
      public function sendHotSpringRoomEdit(param1:*) : void{}
      
      public function sendHotSpringRoomQuickEnter() : void{}
      
      public function sendHotSpringRoomEnterConfirm(param1:int) : void{}
      
      public function sendHotSpringRoomEnter(param1:int, param2:String) : void{}
      
      public function sendHotSpringRoomEnterView(param1:int) : void{}
      
      public function sendHotSpringRoomPlayerRemove() : void{}
      
      public function sendHotSpringRoomPlayerTargetPoint(param1:*) : void{}
      
      public function sendHotSpringRoomRenewalFee(param1:int) : void{}
      
      public function sendHotSpringRoomInvite(param1:int) : void{}
      
      public function sendHotSpringRoomAdminRemovePlayer(param1:int) : void{}
      
      public function sendHotSpringRoomPlayerContinue(param1:Boolean) : void{}
      
      public function sendGetTimeBox(param1:int, param2:int, param3:int = -1, param4:int = -1) : void{}
      
      public function sendAchievementFinish(param1:int) : void{}
      
      public function sendReworkRank(param1:String) : void{}
      
      public function sendLookupEffort(param1:int) : void{}
      
      public function sendBeginFightNpc() : void{}
      
      public function sendRequestUpdate() : void{}
      
      public function sendQuestionReply(param1:int) : void{}
      
      public function sendOpenVip(param1:String, param2:int, param3:Boolean = false) : void{}
      
      public function sendAcademyRegister(param1:int, param2:Boolean, param3:String = null, param4:Boolean = false) : void{}
      
      public function sendAcademyRemoveRegister() : void{}
      
      public function sendAcademyApprentice(param1:int, param2:String) : void{}
      
      public function sendAcademyMaster(param1:int, param2:String) : void{}
      
      public function sendAcademyMasterConfirm(param1:Boolean, param2:int) : void{}
      
      public function sendAcademyApprenticeConfirm(param1:Boolean, param2:int) : void{}
      
      public function sendAcademyFireMaster(param1:int) : void{}
      
      public function sendAcademyFireApprentice(param1:int) : void{}
      
      public function sendUseLog(param1:int) : void{}
      
      public function sendBuyGift(param1:String, param2:int, param3:int, param4:int) : void{}
      
      public function sendReloadGift() : void{}
      
      public function sendSnsMsg(param1:int) : void{}
      
      public function getPlayerCardInfo(param1:int) : void{}
      
      public function sendMoveCards(param1:int, param2:int) : void{}
      
      public function sendOpenViceCard(param1:int) : void{}
      
      public function sendOpenCardBox(param1:int, param2:int, param3:int) : void{}
      
      public function sendOpenRandomBox(param1:int, param2:int) : void{}
      
      public function sendOpenSpecialCardBox(param1:int, param2:int, param3:int) : void{}
      
      public function sendOpenNationWord(param1:int, param2:int, param3:int) : void{}
      
      public function sendUpGradeCard(param1:int) : void{}
      
      public function sendUpdateSLOT(param1:int, param2:int) : void{}
      
      public function sendResetCardSoul(param1:Boolean) : void{}
      
      public function sendCardReset(param1:int, param2:int, param3:Array, param4:Boolean) : void{}
      
      public function sendReplaceCardProp(param1:int) : void{}
      
      public function sendSortCards(param1:Vector.<int>) : void{}
      
      public function sendFirstGetCards() : void{}
      
      public function sendFace(param1:int) : void{}
      
      public function sendOpition(param1:int) : void{}
      
      public function sendConsortionMail(param1:String, param2:String) : void{}
      
      public function sendConsortionPoll(param1:int) : void{}
      
      public function sendConsortionSkill(param1:Boolean, param2:int, param3:int, param4:int = 1) : void{}
      
      public function sendOns() : void{}
      
      public function sendWithBrithday(param1:Vector.<FriendListPlayer>) : void{}
      
      public function sendChangeDesignation(param1:Boolean) : void{}
      
      public function sendDailyRecord() : void{}
      
      public function sendCollectInfoValidate(param1:int, param2:String, param3:int) : void{}
      
      public function sendGoodsExchange(param1:Vector.<SendGoodsExchangeInfo>, param2:int, param3:int, param4:int) : void{}
      
      public function sendTexp(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function sendMark(param1:int, param2:String) : void{}
      
      public function sendCustomFriends(param1:int, param2:int, param3:String) : void{}
      
      public function sendOneOnOneTalk(param1:int, param2:String, param3:Boolean = false) : void{}
      
      public function sendUserLuckyNum(param1:int, param2:Boolean) : void{}
      
      public function sendPicc(param1:int, param2:int) : void{}
      
      public function sendBuyBadge(param1:int) : void{}
      
      public function sendGetEliteGameState() : void{}
      
      public function sendGetSelfRankSroce() : void{}
      
      public function sendGetPaarungDetail(param1:int) : void{}
      
      public function sendEliteGameStart() : void{}
      
      public function sendStartTurn_LeftGun() : void{}
      
      public function sendEndTurn_LeftGun() : void{}
      
      public function sendWishBeadEquip(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void{}
      
      public function sendPetCellUnlock(param1:Boolean, param2:int) : void{}
      
      public function sendPetMove(param1:int, param2:int) : void{}
      
      public function sendPetFightUnFight(param1:int, param2:Boolean = true) : void{}
      
      public function sendPetFeed(param1:int, param2:int, param3:int) : void{}
      
      public function sendEquipPetSkill(param1:int, param2:int, param3:int) : void{}
      
      public function sendPetRename(param1:int, param2:String, param3:Boolean) : void{}
      
      public function sendReleasePet(param1:int, param2:Boolean = false, param3:Boolean = false) : void{}
      
      public function sendAdoptPet(param1:int) : void{}
      
      public function sendRefreshPet(param1:Boolean = false, param2:Boolean = false) : void{}
      
      public function sendUpdatePetInfo(param1:int) : void{}
      
      public function sendPaySkill(param1:int) : void{}
      
      public function sendAddPet(param1:int, param2:int) : void{}
      
      public function sendNewTitleCard(param1:int, param2:int) : void{}
      
      public function enterFarm(param1:int) : void{}
      
      public function seeding(param1:int, param2:int) : void{}
      
      public function sendCompose(param1:int, param2:int = 1) : void{}
      
      public function doMature(param1:int, param2:int, param3:int) : void{}
      
      public function toGather(param1:int, param2:int) : void{}
      
      public function toSpread(param1:Array, param2:int, param3:Boolean) : void{}
      
      public function toSpreadByProsperity(param1:int) : void{}
      
      public function sendWish() : void{}
      
      public function sendChangeSex(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendVipCoupons(param1:int, param2:int, param3:int, param4:String, param5:String) : void{}
      
      public function toFarmHelper(param1:Array, param2:Boolean) : void{}
      
      public function sendBeginHelper(param1:Array) : void{}
      
      public function toKillCrop(param1:int) : void{}
      
      public function toHelperRenewMoney(param1:int, param2:Boolean) : void{}
      
      public function exitFarm(param1:int) : void{}
      
      public function fastForwardGrop(param1:Boolean, param2:Boolean, param3:int) : void{}
      
      public function giftPacks(param1:int) : void{}
      
      public function getFarmPoultryLevel(param1:int) : void{}
      
      public function initFarmTree() : void{}
      
      public function callFarmPoultry(param1:int) : void{}
      
      public function wakeFarmPoultry(param1:uint) : void{}
      
      public function inviteWakeFarmPoultry() : void{}
      
      public function feedFarmPoultry(param1:uint) : void{}
      
      public function farmCondenser(param1:int) : void{}
      
      public function farmWater(param1:int) : void{}
      
      public function getPlayerPropertyAddition() : void{}
      
      public function enterWorldBossRoom() : void{}
      
      public function openOrCloseWorldBossHelper(param1:WorldBossHelperTypeData) : void{}
      
      public function quitWorldBossHelperView() : void{}
      
      public function sendAddPlayer(param1:Point) : void{}
      
      public function sendAddAllWorldBossPlayer() : void{}
      
      public function sendWorldBossRoomMove(param1:int, param2:int, param3:String) : void{}
      
      public function sendWorldBossRoomStauts(param1:int) : void{}
      
      public function sendLeaveBossRoom() : void{}
      
      public function sendBuyWorldBossBuff(param1:Array) : void{}
      
      public function sendNewBuyWorldBossBuff(param1:int, param2:int) : void{}
      
      public function sendRevertPet(param1:int, param2:Boolean) : void{}
      
      public function requestForLuckStone() : void{}
      
      public function sendOpenOneTotem(param1:Boolean, param2:Boolean) : void{}
      
      public function sendNewChickenBox() : void{}
      
      public function sendChickenBoxUseEagleEye(param1:int) : void{}
      
      public function sendChickenBoxTakeOverCard(param1:int) : void{}
      
      public function sendOverShowItems() : void{}
      
      public function sendFlushNewChickenBox() : void{}
      
      public function sendClickStartBntNewChickenBox() : void{}
      
      public function labyrinthRequestUpdate(param1:int) : void{}
      
      public function labyrinthCleanOut(param1:int) : void{}
      
      public function labyrinthSpeededUpCleanOut(param1:int, param2:Boolean) : void{}
      
      public function labyrinthStopCleanOut(param1:int) : void{}
      
      public function figSpiritUpGrade(param1:GemstnoeSendInfo) : void{}
      
      public function fightSpiritRequest() : void{}
      
      public function labyrinthCleanOutTimerComplete(param1:int) : void{}
      
      public function labyrinthDouble(param1:int, param2:Boolean) : void{}
      
      public function labyrinthReset(param1:int) : void{}
      
      public function labyrinthTryAgain(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      public function getspree(param1:Object) : void{}
      
      public function sendHonorUp(param1:int, param2:Boolean) : void{}
      
      public function sendBuyPetExpItem(param1:Boolean) : void{}
      
      public function sendOpenKingBless(param1:int, param2:int, param3:String, param4:Boolean) : void{}
      
      public function sendUseItemKingBless(param1:int, param2:int) : void{}
      
      public function sendTrusteeshipStart(param1:int) : void{}
      
      public function sendTrusteeshipCancel(param1:int) : void{}
      
      public function sendTrusteeshipSpeedUp(param1:int, param2:Boolean) : void{}
      
      public function sendTrusteeshipBuySpirit(param1:Boolean = true) : void{}
      
      public function battleGroundUpdata(param1:int) : void{}
      
      public function battleGroundPlayerUpdata() : void{}
      
      public function sendTrusteeshipUseSpiritItem(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendGetGoods(param1:int) : void{}
      
      public function sendConsortiaBossInfo(param1:int, param2:int = 1) : void{}
      
      public function sendLatentEnergy(param1:int, param2:int, param3:int, param4:int = -1, param5:int = -1) : void{}
      
      public function sendWonderfulActivity(param1:int, param2:int) : void{}
      
      public function requestWonderfulActInit(param1:int) : void{}
      
      public function sendBattleCompanionGive(param1:int, param2:int, param3:int) : void{}
      
      public function addPetEquip(param1:int, param2:int, param3:int) : void{}
      
      public function delPetEquip(param1:int, param2:int) : void{}
      
      public function necklaceStrength(param1:int, param2:int, param3:int = 2) : void{}
      
      public function enterBuried() : void{}
      
      public function rollDice(param1:Boolean = false) : void{}
      
      public function upgradeStartLevel(param1:Boolean = false) : void{}
      
      public function refreshMap() : void{}
      
      public function takeCard(param1:Boolean = false) : void{}
      
      public function outCard() : void{}
      
      public function sendSearchGoodsGainRewards(param1:int) : void{}
      
      public function sendConsBatRequestPlayerInfo() : void{}
      
      public function sendConsBatMove(param1:int, param2:int, param3:String) : void{}
      
      public function sendConsBatChallenge(param1:int) : void{}
      
      public function sendConsBatExit() : void{}
      
      public function sendConsBatConsume(param1:int, param2:Boolean = false) : void{}
      
      public function sendConsBatUpdateScore(param1:int) : void{}
      
      public function enterDayActivity() : void{}
      
      public function sendConsBatConfirmEnter() : void{}
      
      public function sendUpdateSysDate() : void{}
      
      public function sendDragonBoatBuildOrDecorate(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendDragonBoatRefreshBoatStatus() : void{}
      
      public function sendDragonBoatRefreshRank() : void{}
      
      public function sendDragonBoatExchange(param1:int, param2:int) : void{}
      
      public function requestUnWeddingPay(param1:int) : void{}
      
      public function requestShopPay(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:String, param7:String = "") : void{}
      
      public function requestAuctionPay(param1:int, param2:String, param3:String = "") : void{}
      
      public function sendWantStrongBack(param1:int, param2:Boolean, param3:Boolean = false) : void{}
      
      public function isAcceptPayShop(param1:Boolean, param2:int) : void{}
      
      public function isAcceptPayAuc(param1:Boolean, param2:int) : void{}
      
      public function sendForAuction(param1:int, param2:String) : void{}
      
      public function isAcceptPay(param1:Boolean, param2:int) : void{}
      
      public function CampbattleEnterFight(param1:int) : void{}
      
      public function CampbattleRoleMove(param1:int, param2:int, param3:Point) : void{}
      
      public function changeMap() : void{}
      
      public function outCampBatttle() : void{}
      
      public function captureMap(param1:Boolean) : void{}
      
      public function requestPRankList() : void{}
      
      public function requestCRankList() : void{}
      
      public function enterPTPFight(param1:int, param2:int) : void{}
      
      public function returnToPve() : void{}
      
      public function resurrect(param1:Boolean, param2:Boolean = true) : void{}
      
      public function sendGroupPurchaseRefreshData() : void{}
      
      public function sendGroupPurchaseRefreshRankData() : void{}
      
      public function sendGroupPurchaseBuy(param1:int, param2:Boolean) : void{}
      
      public function sendRegressPkg() : void{}
      
      public function sendRegressGetAwardPkg(param1:int) : void{}
      
      public function sendRegressCheckPlayer(param1:String) : void{}
      
      public function sendRegressApplyEnable() : void{}
      
      public function sendRegressApllyPacks() : void{}
      
      public function sendRegressCall(param1:int) : void{}
      
      public function sendRegressRecvPacks() : void{}
      
      public function sendRegressTicketInfo() : void{}
      
      public function sendRegressTicket() : void{}
      
      public function sendExpBlessedData() : void{}
      
      public function sendGameTrusteeship(param1:Boolean) : void{}
      
      public function sendInitTreasueHunting() : void{}
      
      public function sendPayForHunting(param1:Boolean, param2:int) : void{}
      
      public function getAllTreasure() : void{}
      
      public function updateTreasureBag() : void{}
      
      public function sendHuntingByScore() : void{}
      
      public function sendConvertScore(param1:Boolean, param2:int = 0, param3:int = 0) : void{}
      
      public function sendSevenDoubleCallCar(param1:int, param2:Boolean) : void{}
      
      public function sendSevenDoubleStartGame(param1:Boolean) : void{}
      
      public function sendSevenDoubleCancelGame() : void{}
      
      public function sendSevenDoubleReady() : void{}
      
      public function sendSevenDoubleMove() : void{}
      
      public function sendSevenDoubleUseSkill(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      public function sendSevenDoubleCanEnter() : void{}
      
      public function sendBuyEnergy(param1:Boolean) : void{}
      
      public function sendSevenDoubleEnterOrLeaveScene(param1:Boolean) : void{}
      
      public function sendWonderfulActivityGetReward(param1:Vector.<SendGiftInfo>) : void{}
      
      public function sendRingStationGetInfo() : void{}
      
      public function sendBuyBattleCountOrTime(param1:Boolean, param2:Boolean) : void{}
      
      public function sendRingStationChallenge(param1:int, param2:int) : void{}
      
      public function sendRingStationArmory() : void{}
      
      public function sendGetRingStationReward() : void{}
      
      public function sendRingStationBattleField() : void{}
      
      public function sendRingStationFightFlag() : void{}
      
      public function sendRouletteRun() : void{}
      
      public function getBackLockPwdByPhone(param1:int, param2:String = "") : void{}
      
      public function getBackLockPwdByQuestion(param1:int, param2:String = "", param3:String = "") : void{}
      
      public function deletePwdQuestion(param1:int, param2:String = "") : void{}
      
      public function deletePwdByPhone(param1:int, param2:String = "") : void{}
      
      public function checkPhoneBind() : void{}
      
      public function sendActivityDungeonNextPoints(param1:int, param2:Boolean, param3:int = 0) : void{}
      
      public function sendButChristmasGoods(param1:int) : void{}
      
      public function enterChristmasRoomIsTrue() : void{}
      
      public function enterChristmasRoom(param1:Point) : void{}
      
      public function enterMakingSnowManRoom() : void{}
      
      public function getPacksToPlayer(param1:int) : void{}
      
      public function sendLeaveChristmasRoom() : void{}
      
      public function sendChristmasRoomMove(param1:int, param2:int, param3:String) : void{}
      
      public function sendChristmasUpGrade(param1:int, param2:Boolean) : void{}
      
      public function sendStartFightWithMonster(param1:int) : void{}
      
      public function sendBuyPlayingSnowmanVolumes(param1:Boolean) : void{}
      
      public function sendLanternRiddlesQuestion() : void{}
      
      public function sendLanternRiddlesAnswer(param1:int, param2:int, param3:int) : void{}
      
      public function sendLanternRiddlesUseSkill(param1:int, param2:int, param3:int, param4:Boolean = true) : void{}
      
      public function sendLanternRiddlesRankInfo() : void{}
      
      public function getRedPacketInfo() : void{}
      
      public function getBuyinfo() : void{}
      
      public function buybuybuy(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function getRedPacketpublish(param1:String, param2:int, param3:int) : void{}
      
      public function getRedFightKingScore() : void{}
      
      public function getRedPacketRecord(param1:int) : void{}
      
      public function getRobRedPacket(param1:int) : void{}
      
      public function sendCatchBeastViewInfo() : void{}
      
      public function sendCatchBeastChallenge() : void{}
      
      public function sendCatchBeastBuyBuff(param1:Boolean) : void{}
      
      public function sendCatchBeastGetAward(param1:int) : void{}
      
      public function sendAccumulativeLoginAward(param1:int) : void{}
      
      public function sendAvatarCollectionActive(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function sendAvatarCollectionDelayTime(param1:int, param2:int, param3:int) : void{}
      
      public function setCurrentModel(param1:int) : void{}
      
      public function saveDressModel(param1:int, param2:Array) : void{}
      
      public function foldDressItem(param1:Array, param2:int, param3:int) : void{}
      
      public function lockDressBag() : void{}
      
      public function receiveLandersAward() : void{}
      
      public function getFlowerRankInfo(param1:int, param2:int) : void{}
      
      public function sendGetFlowerReward(param1:int, param2:int = 0) : void{}
      
      public function getFlowerRewardStatus() : void{}
      
      public function sendFlower(param1:String, param2:int, param3:String) : void{}
      
      public function sendFlowerRecord() : void{}
      
      public function sendUpdateIntegral() : void{}
      
      public function sendBuyRegressIntegralGoods(param1:int, param2:int) : void{}
      
      public function sendPlayerExit(param1:int) : void{}
      
      public function sendOtherPlayerInfo() : void{}
      
      public function sendPlayerPos(param1:int, param2:int) : void{}
      
      public function sendAddNewPlayer(param1:int) : void{}
      
      public function sendModifyNewPlayerDress() : void{}
      
      public function sendUpdatePets(param1:Boolean, param2:int, param3:int) : void{}
      
      public function sendNewHallPlayerHid(param1:Boolean) : void{}
      
      public function sendNewHallBattle() : void{}
      
      public function sendLoadOtherPlayer() : void{}
      
      public function sendHorseChangeHorse(param1:int) : void{}
      
      public function sendActiveHorsePicCherish(param1:int) : void{}
      
      public function sendHorseUpHorse(param1:int) : void{}
      
      public function sendHorseUpSkill(param1:int, param2:int) : void{}
      
      public function sendHorseTakeUpDownSkill(param1:int, param2:int) : void{}
      
      public function sendBallteHorseTakeUpDownSkill(param1:int, param2:int) : void{}
      
      public function sendBombKingStartBattle() : void{}
      
      public function updateBombKingMainFrame() : void{}
      
      public function updateBombKingRank(param1:int, param2:int) : void{}
      
      public function updateBombKingBattleLog() : void{}
      
      public function updateBKingItemEquip(param1:int, param2:int, param3:int) : void{}
      
      public function getBKingStatueInfo() : void{}
      
      public function requestBKingShowTip() : void{}
      
      public function sendCollectionSceneEnter() : void{}
      
      public function sendCollectionSceneMove(param1:int, param2:int, param3:String) : void{}
      
      public function sendCollectionComplete(param1:int) : void{}
      
      public function sendLeaveCollectionScene() : void{}
      
      public function sendPetRisingStar(param1:int, param2:int, param3:int) : void{}
      
      public function sendPetEvolution(param1:int, param2:int) : void{}
      
      public function sendPetFormInfo() : void{}
      
      public function sendPetFollowOrCall(param1:Boolean, param2:int) : void{}
      
      public function sendPetWake(param1:int) : void{}
      
      public function sendUsePetTemporaryCard(param1:int, param2:int) : void{}
      
      public function sendPetBreak(param1:int, param2:Boolean, param3:Array) : void{}
      
      public function sendBreakInfoRequire(param1:int) : void{}
      
      public function sendEscortCallCar(param1:int, param2:Boolean) : void{}
      
      public function sendEscortStartGame(param1:Boolean) : void{}
      
      public function sendEscortCancelGame() : void{}
      
      public function sendEscortReady() : void{}
      
      public function sendEscortMove() : void{}
      
      public function sendEscortUseSkill(param1:int, param2:Boolean, param3:Boolean, param4:int = 0, param5:int = -1) : void{}
      
      public function sendEscortCanEnter() : void{}
      
      public function sendEscortEnterOrLeaveScene(param1:Boolean) : void{}
      
      public function sendPeerID(param1:int, param2:int, param3:String) : void{}
      
      public function exploreMagicStone(param1:int, param2:Boolean, param3:int = 1) : void{}
      
      public function getMagicStoneScore() : void{}
      
      public function convertMgStoneScore(param1:int, param2:Boolean = true, param3:int = 1) : void{}
      
      public function moveMagicStone(param1:int, param2:int) : void{}
      
      public function lockMagicStone(param1:int) : void{}
      
      public function updateMagicStone(param1:Array) : void{}
      
      public function sortMgStoneBag(param1:Array, param2:int) : void{}
      
      public function updateRemainCount() : void{}
      
      public function updateConsumeRank() : void{}
      
      public function updateRechargeRank() : void{}
      
      public function cooking(param1:int) : void{}
      
      public function cookingGetAward(param1:int) : void{}
      
      public function updateCookingCountByTime() : void{}
      
      public function updateDrgnBoatBuildInfo(param1:int = 0) : void{}
      
      public function commitDrgnBoatMaterial(param1:int) : void{}
      
      public function helpToBuildDrgnBoat(param1:int) : void{}
      
      public function broadcastMissileMC() : void{}
      
      public function enterMagpieBridge() : void{}
      
      public function magpieRollDice() : void{}
      
      public function buyMagpieCount(param1:int, param2:Boolean) : void{}
      
      public function refreshMagpieView() : void{}
      
      public function exitMagpieView() : void{}
      
      public function sendCryptBossFight(param1:int, param2:int) : void{}
      
      public function sendGetShopBuyLimitedCount() : void{}
      
      public function requestRescueItemInfo() : void{}
      
      public function requestRescueFrameInfo(param1:int = 0) : void{}
      
      public function sendRescueChallenge(param1:int) : void{}
      
      public function sendRescueCleanCD(param1:Boolean, param2:int) : void{}
      
      public function sendRescueBuyBuff(param1:int, param2:int, param3:Boolean) : void{}
      
      public function useRescueKingBless() : void{}
      
      public function getRescuePrize(param1:int, param2:int) : void{}
      
      public function enterOrLeaveInsectScene(param1:int, param2:Point = null) : void{}
      
      public function sendFightWithInsect(param1:int) : void{}
      
      public function sendInsectSceneMove(param1:int, param2:int, param3:String) : void{}
      
      public function updateInsectInfo() : void{}
      
      public function updateInsectAreaRank() : void{}
      
      public function updateInsectAreaSelfInfo() : void{}
      
      public function updateInsectLocalRank() : void{}
      
      public function updateInsectLocalSelfInfo() : void{}
      
      public function getInsectPrize(param1:int) : void{}
      
      public function requestCakeStatus() : void{}
      
      public function requestInsectWhistleUse(param1:int) : void{}
      
      public function requestInsectWhistleBuy(param1:int, param2:Boolean) : void{}
      
      public function showHideTitleState(param1:Boolean) : void{}
      
      public function sendEnchant(param1:Boolean) : void{}
      
      public function getNationDayInfo() : void{}
      
      public function exchangeNationalGoods(param1:int) : void{}
      
      public function getHalloweenViewInfo() : void{}
      
      public function getHalloweenExchangeViewInfo() : void{}
      
      public function getHalloweenExchange(param1:int, param2:int = 1) : void{}
      
      public function getHalloweenSetExchange() : void{}
      
      public function getHalloweenCandyNum() : void{}
      
      public function requestRookieRankInfo() : void{}
      
      public function sendBuyLevelFund(param1:Boolean, param2:int) : void{}
      
      public function sendGetLevelFundAward(param1:int) : void{}
      
      public function sendOpenDailyView() : void{}
      
      public function sendForgeSuit(param1:int) : void{}
      
      public function getHomeTempleLevel() : void{}
      
      public function setHomeTempleSelectIndex(param1:int) : void{}
      
      public function setHomeTempleImmolation(param1:int, param2:Boolean) : void{}
      
      public function wishingTreeSendWish(param1:int) : void{}
      
      public function wishingTreeUpdateFrame() : void{}
      
      public function arrange(param1:int) : void{}
      
      public function enterTreasure() : void{}
      
      public function startTreasure() : void{}
      
      public function endTreasure() : void{}
      
      public function doTreasure(param1:int) : void{}
      
      public function wishingTreeGetReward(param1:int) : void{}
      
      public function wishingTreeGetRecord() : void{}
      
      public function enterPyramid() : void{}
      
      public function getVipIntegralShopLimit() : void{}
      
      public function buyVipIntegralShopGoods(param1:int, param2:int) : void{}
      
      public function uploadDraftStyle(param1:String, param2:String) : void{}
      
      public function getPlayerSpecialProperty(param1:int) : void{}
      
      public function sendDraftVoteTicket(param1:int, param2:int) : void{}
      
      public function getToyMachineInfo() : void{}
      
      public function sendToyMachineReward(param1:int, param2:int, param3:Boolean, param4:Boolean) : void{}
      
      public function happyRechargeEnter() : void{}
      
      public function happyRechargeStartLottery() : void{}
      
      public function happyRechargeExchange(param1:int, param2:int) : void{}
      
      public function happyRechargeQuestGetItem(param1:int = 2) : void{}
      
      public function sendMemoryGameInfo() : void{}
      
      public function sendMemoryGameTurnover(param1:int) : void{}
      
      public function sendMemoryGameReset(param1:Boolean, param2:Boolean = false) : void{}
      
      public function sendMemoryGameBuy(param1:int, param2:Boolean) : void{}
      
      public function sendMemoryGameGetReward(param1:int) : void{}
      
      public function sendGuardCoreLevelUp() : void{}
      
      public function sendGuardCoreEquip(param1:int) : void{}
      
      public function getVipAndMerryInfo(param1:int) : void{}
      
      public function sendEnterGame() : void{}
      
      public function sendYGBuyGoods(param1:int) : void{}
      
      public function sendLuckDrawGo() : void{}
      
      public function makeNewYearRice(param1:int, param2:int, param3:Array) : void{}
      
      public function sendCheckNewYearRiceInfo() : void{}
      
      public function sendCheckMakeNewYearFood() : void{}
      
      public function sendNewYearRiceOpen(param1:int) : void{}
      
      public function sendExitYearFoodRoom() : void{}
      
      public function sendInviteYearFoodRoom(param1:Boolean, param2:int, param3:Boolean = false) : void{}
      
      public function sendQuitNewYearRiceRoom(param1:int) : void{}
      
      public function clickAnotherDimensionEnter() : void{}
      
      public function clickAnotherDimenZhanling(param1:int) : void{}
      
      public function clickAnotherDimenSearch() : void{}
      
      public function clickAnotherDimenUpgrade(param1:int, param2:int) : void{}
      
      public function treasurePuzzle_enter() : void{}
      
      public function treasurePuzzle_seeReward() : void{}
      
      public function treasurePuzzle_getReward(param1:int) : void{}
      
      public function treasurePuzzle_savePlayerInfo(param1:String, param2:String, param3:String, param4:int) : void{}
      
      public function treasurePuzzle_usePice(param1:int, param2:int = 1) : void{}
      
      public function petIslandInit(param1:int) : void{}
      
      public function redEnvelopeListInfo() : void{}
      
      public function sendRedEnvelope(param1:int) : void{}
      
      public function getRedEnvelope(param1:int) : void{}
      
      public function redEnvelopeInfo(param1:int) : void{}
      
      public function buyLotteryTicket(param1:int, param2:Array) : void{}
      
      public function updataLotteryPool() : void{}
      
      public function getLotteryPrizeInfo() : void{}
      
      public function sendSignMsg(param1:String) : void{}
      
      public function petIslandBuyBlood(param1:int) : void{}
      
      public function petIslandPlay(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendEntertainment() : void{}
      
      public function buyEntertainment(param1:Boolean = false) : void{}
      
      public function petIslandPrize(param1:int) : void{}
      
      public function eatPetsHandler(param1:int, param2:int, param3:int, param4:Array) : void{}
      
      public function sendCheckMagicStoneNumber() : void{}
      
      public function sendOpenDeed(param1:int, param2:int, param3:String, param4:Boolean) : void{}
      
      public function sendUseItemDeed(param1:int, param2:int) : void{}
      
      public function prayIndianaEnter() : void{}
      
      public function prayIndianaLottery() : void{}
      
      public function prayIndianaGoodsRefresh() : void{}
      
      public function prayIndianaPray(param1:int, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 0.0) : void{}
      
      public function sendGetCSMTimeBox() : void{}
      
      public function sendLuckyStarEnter() : void{}
      
      public function sendLuckyStarClose() : void{}
      
      public function sendLuckyStarTurnComplete() : void{}
      
      public function sendLuckyStarTurn() : void{}
      
      public function enterGodsRoads() : void{}
      
      public function getGodsRoadsAwards(param1:int, param2:int) : void{}
      
      public function sendChickActivationOpenKey(param1:String) : void{}
      
      public function sendChickActivationGetAward(param1:int, param2:int) : void{}
      
      public function sendChickActivationQuery() : void{}
      
      public function DDPlayEnter() : void{}
      
      public function DDPlayStart() : void{}
      
      public function DDPlayExchange(param1:int) : void{}
      
      public function sendUseEveryDayGiftRecord(param1:int, param2:int, param3:int) : void{}
      
      public function openMagicLib(param1:int, param2:int) : void{}
      
      public function magicLibLevelUp(param1:int, param2:int) : void{}
      
      public function magicLibFreeGet(param1:int) : void{}
      
      public function magicLibChargeGet(param1:int) : void{}
      
      public function magicOpenDepot(param1:int, param2:Boolean) : void{}
      
      public function magicboxExtraction(param1:int, param2:int = 1) : void{}
      
      public function magicboxFusion(param1:int, param2:int = 1, param3:Boolean = false) : void{}
      
      public function zodiacRolling() : void{}
      
      public function zodiacGetAward(param1:int) : void{}
      
      public function zodiacGetAwardAll() : void{}
      
      public function zodiacAddCounts(param1:Boolean) : void{}
      
      public function enterSuperWinner() : void{}
      
      public function rollDiceInSuperWinner() : void{}
      
      public function outSuperWinner() : void{}
      
      public function witchBlessing_enter(param1:int = 0) : void{}
      
      public function sendWitchBless(param1:int, param2:Boolean = false) : void{}
      
      public function sendWitchGetAwards(param1:int, param2:Boolean = false) : void{}
      
      public function sevenDayTarget_enter(param1:Boolean) : void{}
      
      public function newPlayerReward_enter() : void{}
      
      public function sevenDayTarget_getReward(param1:int) : void{}
      
      public function newPlayerReward_getReward(param1:int) : void{}
      
      public function sendHorseRaceItemUse(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function sendHorseRaceItemUse2(param1:int, param2:int) : void{}
      
      public function sendHorseRaceEnd(param1:int, param2:int) : void{}
      
      public function buyHorseRaceCount() : void{}
      
      public function sendBoguAdventureEnter() : void{}
      
      public function sendBoguAdventureWalkInfo(param1:int, param2:int = 0, param3:Boolean = true) : void{}
      
      public function sendBoguAdventureUpdateGame(param1:int, param2:Boolean = true) : void{}
      
      public function sendBoguAdventureAcquireAward(param1:int) : void{}
      
      public function sendOutBoguAdventure() : void{}
      
      public function sendGuildMemberWeekStarEnter() : void{}
      
      public function sendGuildMemberWeekStarClose() : void{}
      
      public function sendGuildMemberWeekAddRanking(param1:Array) : void{}
      
      public function sendDaySign(param1:Date) : void{}
      
      public function sendGetCardSoul() : void{}
      
      public function sendGrowthPackageOpen(param1:Boolean) : void{}
      
      public function sendGrowthPackageGetItems(param1:int) : void{}
      
      public function sendFastAuctionBugle(param1:int) : void{}
      
      public function queryDDQiYuanMyInfo() : void{}
      
      public function queryDDQiYuanRankRewardConfig() : void{}
      
      public function sendDDQiYuanOfferTimes(param1:int, param2:Boolean) : void{}
      
      public function sendDDQiYuanOpenTreasureBox(param1:Boolean) : void{}
      
      public function queryDDQiYuanAreaRank(param1:int) : void{}
      
      public function queryDDQiYuanTowerTask() : void{}
      
      public function getDDQiYuanTowerTaskReward(param1:int) : void{}
      
      public function getDDQiYuanJoinReward() : void{}
      
      public function sendAngelInvestmentUpdate() : void{}
      
      public function loginDeviceSendUaToCheck(param1:Boolean) : void{}
      
      public function loginDeviceGetDownReward() : void{}
      
      public function loginDeviceGetDailyReward() : void{}
      
      public function sendAngelInvestmentBuyOne(param1:int, param2:Boolean = false) : void{}
      
      public function sendAngelInvestmentGainOne(param1:int) : void{}
      
      public function sendAngelInvestmentGainAll() : void{}
      
      public function sendAngelInvestmentBuyAll(param1:Boolean = false) : void{}
      
      public function sendBombTurnTableLottery() : void{}
      
      public function requestBombTurnTableData() : void{}
      
      public function sendWasteRecycleStartTurn() : void{}
      
      public function sendWasteRecycleEnter() : void{}
      
      public function sendWasteRecycleGoods(param1:int = 1) : void{}
      
      public function queryOnlineRewardInfo() : void{}
      
      public function getOnlineReward() : void{}
      
      public function queryOnlineRewardBoxConfig() : void{}
      
      public function queryConsortionCallBackInfo() : void{}
      
      public function getConsortionCallBackAward(param1:int) : void{}
      
      public function BuyCallFund() : void{}
      
      public function getCallFund() : void{}
      
      public function queryCallFundInfo() : void{}
      
      public function buyCallLotteryDrawGood(param1:int, param2:int, param3:Boolean) : void{}
      
      public function refreshCallLotteryDrawInfo(param1:int) : void{}
      
      public function queryCallLotteryDrawGoods(param1:int) : void{}
      
      public function inspire(param1:int) : void{}
      
      public function exchangeScore(param1:int, param2:int, param3:int) : void{}
      
      public function cityBattleInfo() : void{}
      
      public function cityBattleScore() : void{}
      
      public function cityBattleJoin(param1:int) : void{}
      
      public function cityBattleRank() : void{}
      
      public function cityBattleExchange(param1:int) : void{}
      
      public function sendGainOldPlayerGift() : void{}
      
      public function getSignBuff(param1:int) : void{}
      
      public function enterDemonChiYouScene() : void{}
      
      public function getDemonChiYouOtherPlayerInfo() : void{}
      
      public function leaveDemonChiYouScene() : void{}
      
      public function buyDemonChiYouRoll(param1:int) : void{}
      
      public function buyDemonChiYouShopItem(param1:int) : void{}
      
      public function getDemonChiYouRankInfo() : void{}
      
      public function getDemonChiYouBossInfo() : void{}
      
      public function getDemonChiYouShopInfo() : void{}
      
      public function requestCardAchievement() : void{}
      
      public function sendCardAchievementType(param1:int) : void{}
      
      public function sendDDTKingGradeInfo() : void{}
      
      public function sendDDTKingGradeReset(param1:Boolean, param2:int) : void{}
      
      public function sendDDTKingGradeUp(param1:int) : void{}
      
      public function sendPetsAwaken() : void{}
      
      public function getConsortiaDomainOtherPlayerInfo() : void{}
      
      public function leaveConsortiaDomainScene() : void{}
      
      public function getConsortiaDomainMonsterInfoInFight() : void{}
      
      public function getConsortiaDomainBuildInfoInFight() : void{}
      
      public function getConsortiaDomainConsortiaInfo() : void{}
      
      public function sendConsortiaDomainMove(param1:Array) : void{}
      
      public function sendConsortiaDomainFight(param1:int) : void{}
      
      public function sendConsortiaDomainActive() : void{}
      
      public function sendConsortiaDomainRepair(param1:int) : void{}
      
      public function getConsortiaDomainKillInfo() : void{}
      
      public function getConsortiaDomainActiveState() : void{}
      
      public function getSevendayProgressCount() : void{}
      
      public function getConsortiaDomainBuildRepairInfo() : void{}
      
      public function sendQuestionAwardAnswer(param1:String) : void{}
      
      public function requestAwardItem() : void{}
      
      public function sendRollDice(param1:int) : void{}
      
      public function sendBombPos(param1:int, param2:int, param3:int, param4:Boolean, param5:Array, param6:Array) : void{}
      
      public function sendHappyMiniGameActiveData() : void{}
      
      public function sendBombStart(param1:int) : void{}
      
      public function sendBombEnterRoom(param1:int) : void{}
      
      public function sendBombGameRank(param1:int, param2:int) : void{}
      
      public function sendBombGameOver() : void{}
      
      public function sendBombGameNext() : void{}
      
      public function sendConsortiaGuradOpenGuard(param1:int) : void{}
      
      public function sendConsortiaGuradLeaveScene() : void{}
      
      public function sendConsortiaGuradFight(param1:int) : void{}
      
      public function sendConsortiaGuradRank() : void{}
      
      public function sendConsortiaGuradPlayerRevive(param1:Boolean) : void{}
      
      public function sendConsortiaGuradGameState() : void{}
      
      public function sendConsortiaGuradBuyBuff(param1:int) : void{}
      
      public function sendRewardTaskQuestOfferInfo() : void{}
      
      public function sendRewardTaskRefreshQuest(param1:Boolean = true) : void{}
      
      public function sendRewardTaskAddTimes(param1:Boolean = true) : void{}
      
      public function sendRewardTaskRefreshReward(param1:Boolean = true) : void{}
      
      public function sendRewardTaskAcceptQuest(param1:Boolean = true) : void{}
      
      public function sendOpenAmuletBox(param1:int, param2:int, param3:int = 1) : void{}
      
      public function sendAmuletActivate(param1:int) : void{}
      
      public function sendAmuletSmash(param1:Array) : void{}
      
      public function sendAmuletMove(param1:int, param2:int) : void{}
      
      public function sendAmuletLock(param1:int) : void{}
      
      public function sendAmuletActivateReplace(param1:int) : void{}
      
      public function sendEquipAmuletBuyNum() : void{}
      
      public function sendEquipAmuletUpgrade(param1:Boolean = false) : void{}
      
      public function sendEquipAmuletActivate(param1:Boolean, param2:Array) : void{}
      
      public function sendEquipAmuletBuyStive(param1:Boolean) : void{}
      
      public function sendEquipAmuletReplace(param1:Boolean) : void{}
      
      public function requestManualInitData() : void{}
      
      public function requestManualPageData(param1:int) : void{}
      
      public function sendManualPageActive(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendManualUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void{}
      
      public function sendIndiana(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function sendIndianaCode(param1:int, param2:int) : void{}
      
      public function sendIndianaEnterGame(param1:int) : void{}
      
      public function sendIndianaHistoryData() : void{}
      
      public function sendIndianaCurrentData(param1:int) : void{}
      
      public function sendHappyMiniGameRankDataList() : void{}
      
      public function rollGameDice() : void{}
      
      public function defendislandInfo(param1:int) : void{}
      
      public function pvePowerBuffRefresh() : void{}
      
      public function pvePowerBuffGetBuff(param1:int) : void{}
      
      public function sendEquipGhost() : void{}
      
      public function sendBankUpdate(param1:int) : void{}
      
      public function sendBanksaveMoney(param1:int, param2:int) : void{}
      
      public function sendBankGetMoney(param1:int, param2:int) : void{}
      
      public function sendBankGetTaskComplete() : void{}
      
      public function addPlayerDressPay() : void{}
      
      public function sendUpdateUserCmd(param1:int) : void{}
      
      public function sendDealStockOrFund(param1:int, param2:int, param3:int, param4:int, param5:int) : void{}
      
      public function sendBuyLoan(param1:int, param2:int) : void{}
      
      public function sendStockSpecific(param1:int, param2:int, param3:int) : void{}
      
      public function sendUserStockAccountInfo() : void{}
      
      public function sendStockNews() : void{}
      
      public function sendStockAward(param1:int) : void{}
      
      public function sendPersonalLimitShop(param1:int) : void{}
      
      public function sendConsortionActiveTargetSchedule() : void{}
      
      public function sendConsortionActiveTagertStatus() : void{}
      
      public function sendConsortionActiveTagertReward(param1:int) : void{}
      
      public function sendMinesArrange() : void{}
      
      public function sendDigHandler(param1:int) : void{}
      
      public function sendUpdataToolHandler(param1:int, param2:int) : void{}
      
      public function sendBuyHandler(param1:int, param2:int) : void{}
      
      public function sendExchangeHandler(param1:int, param2:int) : void{}
      
      public function sendMinesShopHandler() : void{}
      
      public function sendInitHandler() : void{}
      
      public function sendEquipmentLevelUpHandler(param1:int, param2:int, param3:int) : void{}
      
      public function sendTeamChatTalk(param1:int, param2:String) : void{}
      
      public function sendRoomBordenItemUp(param1:int) : void{}
      
      public function sendUseRoomBorden(param1:Boolean, param2:int) : void{}
      
      public function sendSellRoomBordan(param1:int, param2:int) : void{}
      
      public function sendTeamCreate(param1:String, param2:String) : void{}
      
      public function sendTeamGetInfo(param1:int) : void{}
      
      public function sendTeamInvite(param1:int) : void{}
      
      public function sendTeamInviteRepeal(param1:Number) : void{}
      
      public function sendTeamInviteApproval(param1:Number) : void{}
      
      public function sendTeamInviteAccept(param1:Number, param2:Number) : void{}
      
      public function sendTeamCheckInput(param1:Boolean, param2:String) : void{}
      
      public function sendTeamGetInviteList(param1:int) : void{}
      
      public function sendTeamExpeleMember(param1:int) : void{}
      
      public function sendTeamGetRecord(param1:int) : void{}
      
      public function sendTeamGetActive(param1:int) : void{}
      
      public function sendTeamGetSelfActive() : void{}
      
      public function sendTeamDonate(param1:int) : void{}
      
      public function sendTeamExit() : void{}
      
      public function sendChangeTeamName(param1:int, param2:int, param3:String, param4:String) : void{}
      
      public function sendConsortiaGuradBossRank(param1:int) : void{}
      
      public function sendTreasureRoomData() : void{}
      
      public function sendSubmitTransfer(param1:int) : void{}
      
      public function sendUserAllDebris() : void{}
      
      public function sendOnOrOffChip(param1:int, param2:int) : void{}
      
      public function sendSellChips(param1:Array) : void{}
      
      public function sendHammerChip(param1:int, param2:int) : void{}
      
      public function sendCrystalList() : void{}
      
      public function sendTransferChip(param1:int, param2:int) : void{}
      
      public function sendOperationStatus(param1:int, param2:int) : void{}
      
      public function sendTreasureRoomReward(param1:int, param2:Boolean, param3:Boolean) : void{}
      
      public function sendStopExpStorage(param1:int) : void{}
      
      public function sendGetGourdExpStorage() : void{}
      
      public function sendDevilGetInfo() : void{}
      
      public function sendDevilTurnSacrifice(param1:Boolean, param2:int, param3:Boolean = true) : void{}
      
      public function sendDevilTurnScoreConversion(param1:int) : void{}
      
      public function sendDevilTurnBeadConversion(param1:int) : void{}
      
      public function sendDevilTurnOpenBox(param1:int) : void{}
      
      public function sendDevilTurnDiceStart(param1:int) : void{}
      
      public function sendDevilTurnContinueDice(param1:int, param2:Boolean) : void{}
      
      public function sendDevilTurnGetBox(param1:int) : void{}
      
      public function sendDevilTurnBoxExpire(param1:int) : void{}
      
      public function sendDevilTurnBoxAbandon(param1:int) : void{}
      
      public function sendDevilTurnUpdateJackpot() : void{}
   }
}
