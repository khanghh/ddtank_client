package ddt.manager{   import Indiana.IndianaEPackageType;   import baglocked.BaglockedManager;   import cloudBuyLottery.model.CloudBuyLotteryPackageType;   import ddt.data.AccountInfo;   import ddt.data.SendGoodsExchangeInfo;   import ddt.data.player.FriendListPlayer;   import ddt.events.CEvent;   import ddt.utils.CrytoUtils;   import flash.geom.Point;   import flash.utils.ByteArray;   import flash.utils.getTimer;   import foodActivity.event.FoodActivityEvent;   import gemstone.info.GemstnoeSendInfo;   import horseRace.controller.HorseRaceManager;   import road7th.comm.ByteSocket;   import road7th.comm.PackageOut;   import road7th.math.randRange;   import trainer.controller.WeakGuildManager;   import uiModeManager.bombUI.HappyLittleGameManager;   import wonderfulActivity.data.GiftChildInfo;   import wonderfulActivity.data.SendGiftInfo;   import worldBossHelper.data.WorldBossHelperTypeData;      public class GameSocketOut   {                   private var _socket:ByteSocket;            public function GameSocketOut(socket:ByteSocket) { super(); }
            public function sendLogin(acc:AccountInfo, isChangeChannel:Boolean) : void { }
            public function sendWeeklyClick() : void { }
            public function sendLoginDebug() : void { }
            public function sendRandomSuitUse(place:int, isBind:Boolean) : void { }
            public function sendGameLogin(hallType:int, isRnd:int, roomId:int = -1, pass:String = "", isInvite:Boolean = false) : void { }
            public function sendRefreshServer() : void { }
            public function sendReconnection() : void { }
            public function sendFastInviteCall() : void { }
            public function sendSceneLogin(hellType:int) : void { }
            public function sendGameStyle(style:int) : void { }
            public function sendDailyAward(getWay:int) : void { }
            public function sendRestroDaily(date:Date) : void { }
            public function sendSignAward(signCount:int) : void { }
            public function sendBuyGoods(items:Array, types:Array, colors:Array, places:Array, dresses:Array, skin:Array = null, buyFrom:int = 0, goodsTypes:Array = null, arr:Array = null) : void { }
            public function sendNewBuyGoods(id:int, type:int, count:int = 1, colors:String = "", place:int = 0, dresse:Boolean = false, skin:String = "", buyFrom:int = 0, goodsType:int = 1, isBind:Boolean = true) : void { }
            public function sendBuyProp(id:int, bool:Boolean) : void { }
            public function sendSellProp(id:int, GoodsID:int) : void { }
            public function sendQuickBuyGoldBox(buyNumber:int, bool:Boolean) : void { }
            public function sendBuyGiftBag(type:int) : void { }
            public function sendButTransnationalGoods(id:int) : void { }
            public function sendPresentGoods(ids:Array, types:Array, colors:Array, goodTypes:Array, msg:String, nick:String, skin:Array = null, bools:Array = null) : void { }
            public function sendGoodsContinue(data:Array) : void { }
            public function sendSellGoods(position:int) : void { }
            public function sendUpdateGoodsCount() : void { }
            public function sendEmail(param:Object) : void { }
            public function sendUpdateMail(id:int) : void { }
            public function sendDeleteSentMail(id:int) : void { }
            public function sendDeleteMail(id:int) : void { }
            public function untreadEmail(id:int) : void { }
            public function sendGetMail(emailId:int, type:int) : void { }
            public function sendPint() : void { }
            public function sendSuicide(id:int) : void { }
            public function sendKillSelf(id:int) : void { }
            public function sendItemCompose(consortiaState:Boolean) : void { }
            public function sendItemTransfer(transferBefore:Boolean = true, transferAfter:Boolean = true, sBagType:int = 12, sPlace:int = 0, tBagType:int = 12, tPlace:int = 1) : void { }
            public function sendItemStrength(consortiaState:Boolean, isAllInject:Boolean) : void { }
            public function sendItemExalt() : void { }
            public function sendExaltRestore() : void { }
            public function sendItemLianhua(operation:int, count:int, matieria:Array, equipBagType:int, equipPlace:int, luckyBagType:int, luckyPlace:int) : void { }
            public function sendBeadEquip(pBeadPlace:int, pAimPlace:int) : void { }
            public function sendBeadUpgrade(pSlots:Array) : void { }
            public function sendOpenBead(pIndex:int, bool:Boolean) : void { }
            public function sendBeadLock(pBeadPlace:int) : void { }
            public function sendBeadOpenHole(pHoleIndex:int, pDrillID:int, num:int = 1) : void { }
            public function sendBeadAdvanceExchange(itemId:int, mainIdIndex:int, auxiliaryIDindex:int) : void { }
            public function sendItemEmbedBackout(itemPlace:int, templateID:int) : void { }
            public function sendItemOpenFiveSixHole(itemPlace:int, number:int, drill:int) : void { }
            public function sendItemTrend(itemBagType:int, itemPlace:int, propBagType:int, propPlace:int, trendType:int) : void { }
            public function sendClearStoreBag() : void { }
            public function sendCheckCode(code:String) : void { }
            public function sendEquipRetrieve() : void { }
            public function sendItemFusion(fusionId:int, count:int, withoutComposeAttr:Boolean = false) : void { }
            public function sendSBugle(msg:String) : void { }
            public function sendBBugle(msg:String, templateID:int) : void { }
            public function sendCBugle(msg:String) : void { }
            public function sendDefyAffiche(msg:String, bool:Boolean) : void { }
            public function sendGameMode(style:int) : void { }
            public function sendAddFriend(nick:String, Relation:int, isSendEmail:Boolean = false, isSameCity:Boolean = false) : void { }
            public function sendDelFriend(id:int) : void { }
            public function sendFriendState(state:int) : void { }
            public function sendBagLocked(pwd:String, type:int, newPwd:String = "", questionOne:String = "", answerOne:String = "", questionTwo:String = "", answerTwo:String = "") : void { }
            public function sendBagLockedII(psw:String, questionOne:String, answerOne:String, questionTwo:String, answerTwo:String) : void { }
            public function sendConsortiaEquipConstrol(arr:Array) : void { }
            public function sendErrorMsg(msg:String) : void { }
            public function sendItemOverDue(bagtype:int, place:int) : void { }
            public function sendHideLayer(categoryid:int, hide:Boolean) : void { }
            public function sendQuestManuGet(id:int) : void { }
            public function sendQuestAdd(arr:Array) : void { }
            public function sendQuestRemove(id:int) : void { }
            public function sendQuestFinish(id:int, itemId:int, type:int = 0) : void { }
            public function sendQuestOneToFinish(questId:int) : void { }
            public function sendImproveQuest(questId:int, bool:Boolean) : void { }
            public function sendQuestCheck(id:int, conid:int, value:int = 1) : void { }
            public function sendItemOpenUp(bagtype:int, place:int, count:int = 1, isBand:Boolean = false) : void { }
            public function sendUseLoveFeelingly(bagtype:int, place:int, count:int = 1) : void { }
            public function sendItemEquip(idOrNickName:*, isUseNickName:Boolean = false) : void { }
            public function sendMateTime(id:int) : void { }
            public function sendPlayerGift(id:int) : void { }
            public function sendActivePullDown(id:int, pass:String) : void { }
            public function auctionGood(bagType:int, place:int, payType:int, price:int, mouthful:int, validDate:int, count:int, isAuctionBugle:Boolean) : void { }
            public function auctionCancelSell(id:int) : void { }
            public function auctionBid(id:int, price:int) : void { }
            public function syncStep(id:int, save:Boolean = true) : void { }
            public function syncWeakStep(id:int) : void { }
            public function sendCreateConsortia(name:String, bool:Boolean) : void { }
            public function sendConsortiaTryIn(consortiaid:int) : void { }
            public function sendConsortiaCancelTryIn() : void { }
            public function sendConsortiaInvate(name:String) : void { }
            public function sendReleaseConsortiaTask(type:int, bool:Boolean = true, level:int = 1, lastType:int = 0, lockId1:int = 0, lockId2:int = 0) : void { }
            public function addSpeed(type:int, id:int) : void { }
            public function sendConsortiaInvatePass(id:int) : void { }
            public function sendConsortiaInvateDelete(id:int) : void { }
            public function sendConsortiaUpdateDescription(description:String) : void { }
            public function sendConsortiaUpdatePlacard(placard:String) : void { }
            public function sendConsortiaUpdateDuty(dutyid:int, dutyname:String, right:int) : void { }
            public function sendConsortiaUpgradeDuty(dutyid:int, updown:int) : void { }
            public function sendConsoritaApplyStatusOut(b:Boolean) : void { }
            public function sendConsortiaOut(playerid:int) : void { }
            public function sendConsortiaMemberGrade(id:int, isUpgrade:Boolean) : void { }
            public function sendConsortiaUserRemarkUpdate(id:int, msg:String) : void { }
            public function sendConsortiaDutyDelete(dutyid:int) : void { }
            public function sendConsortiaTryinPass(id:int) : void { }
            public function sendConsortiaTryinDelete(id:int) : void { }
            public function sendForbidSpeak(id:int, forbid:Boolean) : void { }
            public function sendConsortiaDismiss() : void { }
            public function sendConsortiaChangeChairman(nickName:String = "") : void { }
            public function sendConsortiaRichOffer(num:int) : void { }
            public function sendDonate(id:int, num:int) : void { }
            public function sendConsortiaLevelUp(type:int) : void { }
            public function sendAirPlane() : void { }
            public function useDeputyWeapon() : void { }
            public function sendGamePick(bombId:int) : void { }
            public function sendPetSkill(skillID:int, type:int = 1) : void { }
            public function sendPackage(pkg:PackageOut) : void { }
            public function sendMoveGoods(bagtype:int, place:int, tobagType:int, toplace:int, count:int = 1, allMove:Boolean = false) : void { }
            public function reclaimGoods(bagtype:int, place:int, count:int = 1) : void { }
            public function sendMoveGoodsAll(bagType:int, array:Array, startPlace:int, isSegistration:Boolean = false) : void { }
            public function sendForSwitch() : void { }
            public function sendCIDCheck() : void { }
            public function sendCIDInfo(name:String, CID:String) : void { }
            public function sendChangeColor(cardBagType:int, cardPlace:int, itemBagType:int, itemPlace:int, color:String, skin:String, templateID:int) : void { }
            public function sendUseCard(bagType:int, cardPlace:int, items:Array, type:int, ignoreBagLock:Boolean = false, bool:Boolean = true, count:int = 1) : void { }
            public function sendUseProp(bagType:int, cardPlace:int, items:Array, type:int, ignoreBagLock:Boolean = false) : void { }
            public function sendUseChangeColorShell(bagType:int, cardPlace:int) : void { }
            public function sendChangeColorShellTimeOver(bagtype:int, place:int) : void { }
            public function sendRouletteBox(bagType:int, place:int, boxId:int = -1) : void { }
            public function sendStartTurn(type:int = 1) : void { }
            public function sendFinishRoulette() : void { }
            public function sendSellAll() : void { }
            public function sendconverted(isConver:Boolean, totalSorce:int = 0, lotteryScore:int = 0) : void { }
            public function sendExchange() : void { }
            public function sendOpenAll() : void { }
            public function sendOpenDead(bagType:int, place:int, id:int) : void { }
            public function sendRequestAwards(type:int) : void { }
            public function sendQequestBadLuck(isOpen:Boolean = false) : void { }
            public function sendQequestLuckky(isOpen:Boolean = false) : void { }
            public function sendUseReworkName(bagType:int, place:int, newName:String) : void { }
            public function sendUseConsortiaReworkName(consortiaID:int, bagType:int, place:int, newName:String) : void { }
            public function sendValidateMarry(id:int) : void { }
            public function sendPropose(id:int, text:String, useBugle:Boolean, bool:Boolean) : void { }
            public function sendProposeRespose(result:Boolean, id:int, answerId:int) : void { }
            public function sendUnmarry(isPlayMovie:Boolean = false) : void { }
            public function sendMarryRoomLogin() : void { }
            public function sendExitMarryRoom() : void { }
            public function sendCreateRoom(roomName:String, password:String, mapID:int, valideTimes:int, canInvite:Boolean, discription:String, seniorType:int) : void { }
            public function sendEnterRoom(id:int, psw:String, sceneIndex:int = 1) : void { }
            public function sendExitRoom() : void { }
            public function sendCurrentState(index:uint) : void { }
            public function sendUpdateRoomList(hallType:int, updateType:int, fbId:int = 10000, hardLv:int = 1013) : void { }
            public function sendChurchMove(endX:int, endY:int, path:String) : void { }
            public function sendStartWedding(isBind:Boolean = false) : void { }
            public function sendChurchContinuation(hours:int) : void { }
            public function sendChurchInvite(id:int) : void { }
            public function sendChurchLargess(num:uint) : void { }
            public function refund() : void { }
            public function requestRefund() : void { }
            public function sendUseFire(playerID:int, fireTemplateID:int, isBind:Boolean = false) : void { }
            public function sendChurchKick(id:int) : void { }
            public function sendChurchMovieOver(ID:int, password:String) : void { }
            public function sendChurchForbid(id:int) : void { }
            public function sendPosition(x:Number, y:Number) : void { }
            public function sendModifyChurchDiscription(roomName:String, modifyPSW:Boolean, psw:String, discription:String) : void { }
            public function sendSceneChange(sceneIndex:int) : void { }
            public function sendGunSalute(userID:int, templeteID:int) : void { }
            public function sendRequestSeniorChurch() : void { }
            public function sendRegisterInfo(UserID:int, IsPublishEquip:Boolean, introduction:String = null) : void { }
            public function sendModifyInfo(IsPublishEquip:Boolean, introduction:String = null) : void { }
            public function sendForMarryInfo(MarryInfoID:int) : void { }
            public function sendGetLinkGoodsInfo(type:int, key:String, templeteIDorItemID:String = "") : void { }
            public function sendGetTropToBag(place:int) : void { }
            public function createUserGuide(roomType:int = 10) : void { }
            public function enterUserGuide(pveId:int, roomType:int = 10) : void { }
            public function userGuideStart() : void { }
            public function sendSaveDB() : void { }
            public function createMonster() : void { }
            public function deleteMonster() : void { }
            public function sendHotSpringEnter() : void { }
            public function sendHotSpringRoomCreate(roomVo:*) : void { }
            public function sendHotSpringRoomEdit(roomVo:*) : void { }
            public function sendHotSpringRoomQuickEnter() : void { }
            public function sendHotSpringRoomEnterConfirm(roomID:int) : void { }
            public function sendHotSpringRoomEnter(roomID:int, roomPassword:String) : void { }
            public function sendHotSpringRoomEnterView(state:int) : void { }
            public function sendHotSpringRoomPlayerRemove() : void { }
            public function sendHotSpringRoomPlayerTargetPoint(playerVO:*) : void { }
            public function sendHotSpringRoomRenewalFee(roomID:int) : void { }
            public function sendHotSpringRoomInvite(playerID:int) : void { }
            public function sendHotSpringRoomAdminRemovePlayer(playerID:int) : void { }
            public function sendHotSpringRoomPlayerContinue(isContinue:Boolean) : void { }
            public function sendGetTimeBox(boxType:int, boxNumber:int, lession:int = -1, level:int = -1) : void { }
            public function sendAchievementFinish(id:int) : void { }
            public function sendReworkRank(rank:String) : void { }
            public function sendLookupEffort(id:int) : void { }
            public function sendBeginFightNpc() : void { }
            public function sendRequestUpdate() : void { }
            public function sendQuestionReply(questionReply:int) : void { }
            public function sendOpenVip(name:String, days:int, bool:Boolean = false) : void { }
            public function sendAcademyRegister(UserID:int, IsPublishEquip:Boolean, introduction:String = null, isAmend:Boolean = false) : void { }
            public function sendAcademyRemoveRegister() : void { }
            public function sendAcademyApprentice(id:int, introduction:String) : void { }
            public function sendAcademyMaster(id:int, introduction:String) : void { }
            public function sendAcademyMasterConfirm(value:Boolean, id:int) : void { }
            public function sendAcademyApprenticeConfirm(value:Boolean, id:int) : void { }
            public function sendAcademyFireMaster(id:int) : void { }
            public function sendAcademyFireApprentice(id:int) : void { }
            public function sendUseLog(type:int) : void { }
            public function sendBuyGift(nickName:String, goodsId:int, count:int, type:int) : void { }
            public function sendReloadGift() : void { }
            public function sendSnsMsg($typeId:int) : void { }
            public function getPlayerCardInfo(playerId:int) : void { }
            public function sendMoveCards(from:int, to:int) : void { }
            public function sendOpenViceCard(place:int) : void { }
            public function sendOpenCardBox(id:int, num:int, bagType:int) : void { }
            public function sendOpenRandomBox(id:int, num:int) : void { }
            public function sendOpenSpecialCardBox(id:int, num:int, bagType:int) : void { }
            public function sendOpenNationWord(id:int, place:int, count:int) : void { }
            public function sendUpGradeCard(place:int) : void { }
            public function sendUpdateSLOT(place:int, num:int) : void { }
            public function sendResetCardSoul(bool:Boolean) : void { }
            public function sendCardReset(place:int, level:int, lockStates:Array, isBind:Boolean) : void { }
            public function sendReplaceCardProp(place:int) : void { }
            public function sendSortCards(data:Vector.<int>) : void { }
            public function sendFirstGetCards() : void { }
            public function sendFace(id:int) : void { }
            public function sendOpition(value:int) : void { }
            public function sendConsortionMail(topic:String, content:String) : void { }
            public function sendConsortionPoll(candidateID:int) : void { }
            public function sendConsortionSkill(isopen:Boolean, id:int, vaildDay:int, type:int = 1) : void { }
            public function sendOns() : void { }
            public function sendWithBrithday(vec:Vector.<FriendListPlayer>) : void { }
            public function sendChangeDesignation(boo:Boolean) : void { }
            public function sendDailyRecord() : void { }
            public function sendCollectInfoValidate(type:int, validate:String, id:int) : void { }
            public function sendGoodsExchange(list:Vector.<SendGoodsExchangeInfo>, ActiveID:int, count:int, awardIndex:int) : void { }
            public function sendTexp(type:int, templateID:int, count:int, place:int) : void { }
            public function sendMark(id:int, markName:String) : void { }
            public function sendCustomFriends(type:int, id:int, name:String) : void { }
            public function sendOneOnOneTalk(id:int, content:String, isAutoReply:Boolean = false) : void { }
            public function sendUserLuckyNum(num:int, hasChoose:Boolean) : void { }
            public function sendPicc(id:int, price:int) : void { }
            public function sendBuyBadge(id:int) : void { }
            public function sendGetEliteGameState() : void { }
            public function sendGetSelfRankSroce() : void { }
            public function sendGetPaarungDetail(type:int) : void { }
            public function sendEliteGameStart() : void { }
            public function sendStartTurn_LeftGun() : void { }
            public function sendEndTurn_LeftGun() : void { }
            public function sendWishBeadEquip(equipPlace:int, equipBagType:int, equipId:int, beadPlace:int, beadBagType:int, beadId:int) : void { }
            public function sendPetCellUnlock(isBind:Boolean, times:int) : void { }
            public function sendPetMove(fromPlace:int, toPlace:int) : void { }
            public function sendPetFightUnFight(place:int, isFight:Boolean = true) : void { }
            public function sendPetFeed(foodPlace:int, foodBag:int, petPlace:int) : void { }
            public function sendEquipPetSkill(petPlace:int, skillID:int, index:int) : void { }
            public function sendPetRename(place:int, name:String, bool:Boolean) : void { }
            public function sendReleasePet(place:int, isPay:Boolean = false, isBind:Boolean = false) : void { }
            public function sendAdoptPet(index:int) : void { }
            public function sendRefreshPet(isPay:Boolean = false, bool:Boolean = false) : void { }
            public function sendUpdatePetInfo(plyaerID:int) : void { }
            public function sendPaySkill(placeID:int) : void { }
            public function sendAddPet(placeID:int, bagType:int) : void { }
            public function sendNewTitleCard(placeID:int, bagType:int) : void { }
            public function enterFarm(useid:int) : void { }
            public function seeding(fieldID:int, seedsId:int) : void { }
            public function sendCompose(foodID:int, count:int = 1) : void { }
            public function doMature(type:int, fieldID:int, manureId:int) : void { }
            public function toGather(userid:int, fieldid:int) : void { }
            public function toSpread(idArr:Array, payDate:int, bool:Boolean) : void { }
            public function toSpreadByProsperity(id:int) : void { }
            public function sendWish() : void { }
            public function sendChangeSex(bagType:int, place:int, num:int = 1) : void { }
            public function sendVipCoupons(bagType:int, place:int, count:int, content:String, nickName:String) : void { }
            public function toFarmHelper(temp:Array, isAuto:Boolean) : void { }
            public function sendBeginHelper(array:Array) : void { }
            public function toKillCrop(fieldId:int) : void { }
            public function toHelperRenewMoney(hour:int, bool:Boolean) : void { }
            public function exitFarm(playerID:int) : void { }
            public function fastForwardGrop(isBind:Boolean, isAll:Boolean, index:int) : void { }
            public function giftPacks(id:int) : void { }
            public function getFarmPoultryLevel(userId:int) : void { }
            public function initFarmTree() : void { }
            public function callFarmPoultry(treeLevel:int) : void { }
            public function wakeFarmPoultry(id:uint) : void { }
            public function inviteWakeFarmPoultry() : void { }
            public function feedFarmPoultry(id:uint) : void { }
            public function farmCondenser(num:int) : void { }
            public function farmWater(num:int) : void { }
            public function getPlayerPropertyAddition() : void { }
            public function enterWorldBossRoom() : void { }
            public function openOrCloseWorldBossHelper(data:WorldBossHelperTypeData) : void { }
            public function quitWorldBossHelperView() : void { }
            public function sendAddPlayer(position:Point) : void { }
            public function sendAddAllWorldBossPlayer() : void { }
            public function sendWorldBossRoomMove(endX:int, endY:int, path:String) : void { }
            public function sendWorldBossRoomStauts(status:int) : void { }
            public function sendLeaveBossRoom() : void { }
            public function sendBuyWorldBossBuff(arr:Array) : void { }
            public function sendNewBuyWorldBossBuff(type:int, count:int) : void { }
            public function sendRevertPet(petPos:int, bool:Boolean) : void { }
            public function requestForLuckStone() : void { }
            public function sendOpenOneTotem(isActPro:Boolean, isBind:Boolean) : void { }
            public function sendNewChickenBox() : void { }
            public function sendChickenBoxUseEagleEye(position:int) : void { }
            public function sendChickenBoxTakeOverCard(position:int) : void { }
            public function sendOverShowItems() : void { }
            public function sendFlushNewChickenBox() : void { }
            public function sendClickStartBntNewChickenBox() : void { }
            public function labyrinthRequestUpdate(type:int) : void { }
            public function labyrinthCleanOut(type:int) : void { }
            public function labyrinthSpeededUpCleanOut(type:int, bool:Boolean) : void { }
            public function labyrinthStopCleanOut(type:int) : void { }
            public function figSpiritUpGrade(obj:GemstnoeSendInfo) : void { }
            public function fightSpiritRequest() : void { }
            public function labyrinthCleanOutTimerComplete(type:int) : void { }
            public function labyrinthDouble(type:int, value:Boolean) : void { }
            public function labyrinthReset(type:int) : void { }
            public function labyrinthTryAgain(type:int, value:Boolean, bool:Boolean) : void { }
            public function getspree(value:Object) : void { }
            public function sendHonorUp(type:int, bool:Boolean) : void { }
            public function sendBuyPetExpItem(bool:Boolean) : void { }
            public function sendOpenKingBless(type:int, playerId:int, msg:String, bool:Boolean) : void { }
            public function sendUseItemKingBless(place:int, bagType:int) : void { }
            public function sendTrusteeshipStart(questId:int) : void { }
            public function sendTrusteeshipCancel(questId:int) : void { }
            public function sendTrusteeshipSpeedUp(questId:int, bool:Boolean) : void { }
            public function sendTrusteeshipBuySpirit(bool:Boolean = true) : void { }
            public function battleGroundUpdata(type:int) : void { }
            public function battleGroundPlayerUpdata() : void { }
            public function sendTrusteeshipUseSpiritItem(place:int, bagType:int, num:int = 1) : void { }
            public function sendGetGoods(type:int) : void { }
            public function sendConsortiaBossInfo(type:int, callLevel:int = 1) : void { }
            public function sendLatentEnergy(type:int, equipBagType:int, equipPlace:int, itemBagType:int = -1, itemPlace:int = -1) : void { }
            public function sendWonderfulActivity(type:int, id:int) : void { }
            public function requestWonderfulActInit(type:int) : void { }
            public function sendBattleCompanionGive(id:int, bagType:int, place:int) : void { }
            public function addPetEquip(place:int, petIndex:int, bagType:int) : void { }
            public function delPetEquip(petIndex:int, type:int) : void { }
            public function necklaceStrength(num:int, place:int, type:int = 2) : void { }
            public function enterBuried() : void { }
            public function rollDice(bool:Boolean = false) : void { }
            public function upgradeStartLevel(bool:Boolean = false) : void { }
            public function refreshMap() : void { }
            public function takeCard(bool:Boolean = false) : void { }
            public function outCard() : void { }
            public function sendSearchGoodsGainRewards(index:int) : void { }
            public function sendConsBatRequestPlayerInfo() : void { }
            public function sendConsBatMove(endX:int, endY:int, path:String) : void { }
            public function sendConsBatChallenge(id:int) : void { }
            public function sendConsBatExit() : void { }
            public function sendConsBatConsume(type:int, isBind:Boolean = false) : void { }
            public function sendConsBatUpdateScore(type:int) : void { }
            public function enterDayActivity() : void { }
            public function sendConsBatConfirmEnter() : void { }
            public function sendUpdateSysDate() : void { }
            public function sendDragonBoatBuildOrDecorate(type:int, count:int, flag:Boolean = false) : void { }
            public function sendDragonBoatRefreshBoatStatus() : void { }
            public function sendDragonBoatRefreshRank() : void { }
            public function sendDragonBoatExchange(goodsId:int, count:int) : void { }
            public function requestUnWeddingPay(friendsID:int) : void { }
            public function requestShopPay(goodsIds:Array, types:Array, goodsTypes:Array, colors:Array, skins:Array, name:String, msg:String = "") : void { }
            public function requestAuctionPay(auctionID:int, name:String, msg:String = "") : void { }
            public function sendWantStrongBack(type:int, findBackType:Boolean, isBand:Boolean = false) : void { }
            public function isAcceptPayShop(isAcceptPay:Boolean, id:int) : void { }
            public function isAcceptPayAuc(isAcceptPay:Boolean, id:int) : void { }
            public function sendForAuction(id:int, name:String) : void { }
            public function isAcceptPay(isAcceptPay:Boolean, id:int) : void { }
            public function CampbattleEnterFight(id:int) : void { }
            public function CampbattleRoleMove(zoneID:int, userID:int, p:Point) : void { }
            public function changeMap() : void { }
            public function outCampBatttle() : void { }
            public function captureMap(bool:Boolean) : void { }
            public function requestPRankList() : void { }
            public function requestCRankList() : void { }
            public function enterPTPFight(zoneID:int, userID:int) : void { }
            public function returnToPve() : void { }
            public function resurrect(isBind:Boolean, isCost:Boolean = true) : void { }
            public function sendGroupPurchaseRefreshData() : void { }
            public function sendGroupPurchaseRefreshRankData() : void { }
            public function sendGroupPurchaseBuy(num:int, isBand:Boolean) : void { }
            public function sendRegressPkg() : void { }
            public function sendRegressGetAwardPkg(awardID:int) : void { }
            public function sendRegressCheckPlayer(playerName:String) : void { }
            public function sendRegressApplyEnable() : void { }
            public function sendRegressApllyPacks() : void { }
            public function sendRegressCall(id:int) : void { }
            public function sendRegressRecvPacks() : void { }
            public function sendRegressTicketInfo() : void { }
            public function sendRegressTicket() : void { }
            public function sendExpBlessedData() : void { }
            public function sendGameTrusteeship(flag:Boolean) : void { }
            public function sendInitTreasueHunting() : void { }
            public function sendPayForHunting(isBind:Boolean, count:int) : void { }
            public function getAllTreasure() : void { }
            public function updateTreasureBag() : void { }
            public function sendHuntingByScore() : void { }
            public function sendConvertScore(isConver:Boolean, totalSorce:int = 0, lotteryScore:int = 0) : void { }
            public function sendSevenDoubleCallCar(carType:int, isBand:Boolean) : void { }
            public function sendSevenDoubleStartGame(isBand:Boolean) : void { }
            public function sendSevenDoubleCancelGame() : void { }
            public function sendSevenDoubleReady() : void { }
            public function sendSevenDoubleMove() : void { }
            public function sendSevenDoubleUseSkill(type:int, isBand:Boolean, isFree:Boolean) : void { }
            public function sendSevenDoubleCanEnter() : void { }
            public function sendBuyEnergy(isBand:Boolean) : void { }
            public function sendSevenDoubleEnterOrLeaveScene(isEnter:Boolean) : void { }
            public function sendWonderfulActivityGetReward(sendInfoVec:Vector.<SendGiftInfo>) : void { }
            public function sendRingStationGetInfo() : void { }
            public function sendBuyBattleCountOrTime(isBand:Boolean, timeFlag:Boolean) : void { }
            public function sendRingStationChallenge(userId:int, rank:int) : void { }
            public function sendRingStationArmory() : void { }
            public function sendGetRingStationReward() : void { }
            public function sendRingStationBattleField() : void { }
            public function sendRingStationFightFlag() : void { }
            public function sendRouletteRun() : void { }
            public function getBackLockPwdByPhone(step:int, str1:String = "") : void { }
            public function getBackLockPwdByQuestion(step:int, str1:String = "", str2:String = "") : void { }
            public function deletePwdQuestion(step:int, str1:String = "") : void { }
            public function deletePwdByPhone(step:int, str1:String = "") : void { }
            public function checkPhoneBind() : void { }
            public function sendActivityDungeonNextPoints(type:int, flag:Boolean, playerID:int = 0) : void { }
            public function sendButChristmasGoods(id:int) : void { }
            public function enterChristmasRoomIsTrue() : void { }
            public function enterChristmasRoom(point:Point) : void { }
            public function enterMakingSnowManRoom() : void { }
            public function getPacksToPlayer(num:int) : void { }
            public function sendLeaveChristmasRoom() : void { }
            public function sendChristmasRoomMove(endX:int, endY:int, path:String) : void { }
            public function sendChristmasUpGrade(num:int, isDouble:Boolean) : void { }
            public function sendStartFightWithMonster(pMonsterID:int) : void { }
            public function sendBuyPlayingSnowmanVolumes(isBand:Boolean) : void { }
            public function sendLanternRiddlesQuestion() : void { }
            public function sendLanternRiddlesAnswer(id:int, index:int, option:int) : void { }
            public function sendLanternRiddlesUseSkill(id:int, index:int, type:int, isBand:Boolean = true) : void { }
            public function sendLanternRiddlesRankInfo() : void { }
            public function getRedPacketInfo() : void { }
            public function getBuyinfo() : void { }
            public function buybuybuy(type:int, index:int, country:int, num:int) : void { }
            public function getRedPacketpublish(strName:String, totalMoney:int, giftCount:int) : void { }
            public function getRedFightKingScore() : void { }
            public function getRedPacketRecord(id:int) : void { }
            public function getRobRedPacket(id:int) : void { }
            public function sendCatchBeastViewInfo() : void { }
            public function sendCatchBeastChallenge() : void { }
            public function sendCatchBeastBuyBuff(isBind:Boolean) : void { }
            public function sendCatchBeastGetAward(boxID:int) : void { }
            public function sendAccumulativeLoginAward(templeteId:int) : void { }
            public function sendAvatarCollectionActive(id:int, itemId:int, sex:int, type:int) : void { }
            public function sendAvatarCollectionDelayTime(id:int, count:int, type:int) : void { }
            public function setCurrentModel(index:int) : void { }
            public function saveDressModel(index:int, arr:Array) : void { }
            public function foldDressItem(arr:Array, firstPackageType:int, secPackageType:int) : void { }
            public function lockDressBag() : void { }
            public function receiveLandersAward() : void { }
            public function getFlowerRankInfo(type:int, page:int) : void { }
            public function sendGetFlowerReward(type:int, index:int = 0) : void { }
            public function getFlowerRewardStatus() : void { }
            public function sendFlower(playerName:String, num:int, message:String) : void { }
            public function sendFlowerRecord() : void { }
            public function sendUpdateIntegral() : void { }
            public function sendBuyRegressIntegralGoods(id:int, num:int) : void { }
            public function sendPlayerExit(id:int) : void { }
            public function sendOtherPlayerInfo() : void { }
            public function sendPlayerPos(x:int, y:int) : void { }
            public function sendAddNewPlayer(id:int) : void { }
            public function sendModifyNewPlayerDress() : void { }
            public function sendUpdatePets(flag:Boolean, id:int, petsID:int) : void { }
            public function sendNewHallPlayerHid(flag:Boolean) : void { }
            public function sendNewHallBattle() : void { }
            public function sendLoadOtherPlayer() : void { }
            public function sendHorseChangeHorse(tag:int) : void { }
            public function sendActiveHorsePicCherish(place:int) : void { }
            public function sendHorseUpHorse(count:int) : void { }
            public function sendHorseUpSkill(skillId:int, count:int) : void { }
            public function sendHorseTakeUpDownSkill(skillId:int, status:int) : void { }
            public function sendBallteHorseTakeUpDownSkill(skillid:int, place:int) : void { }
            public function sendBombKingStartBattle() : void { }
            public function updateBombKingMainFrame() : void { }
            public function updateBombKingRank(type:int, page:int) : void { }
            public function updateBombKingBattleLog() : void { }
            public function updateBKingItemEquip(useId:int, areaId:int, type:int) : void { }
            public function getBKingStatueInfo() : void { }
            public function requestBKingShowTip() : void { }
            public function sendCollectionSceneEnter() : void { }
            public function sendCollectionSceneMove(endX:int, endY:int, path:String) : void { }
            public function sendCollectionComplete(collectedId:int) : void { }
            public function sendLeaveCollectionScene() : void { }
            public function sendPetRisingStar(templeteId:int, count:int, place:int) : void { }
            public function sendPetEvolution(templeteId:int, count:int) : void { }
            public function sendPetFormInfo() : void { }
            public function sendPetFollowOrCall(flag:Boolean, id:int) : void { }
            public function sendPetWake(id:int) : void { }
            public function sendUsePetTemporaryCard(bagType:int, place:int) : void { }
            public function sendPetBreak(tagPet:int, useProtect:Boolean, eatPetPosList:Array) : void { }
            public function sendBreakInfoRequire(targetGrade:int) : void { }
            public function sendEscortCallCar(carType:int, isBand:Boolean) : void { }
            public function sendEscortStartGame(isBand:Boolean) : void { }
            public function sendEscortCancelGame() : void { }
            public function sendEscortReady() : void { }
            public function sendEscortMove() : void { }
            public function sendEscortUseSkill(type:int, isBand:Boolean, isFree:Boolean, otherId:int = 0, otherZone:int = -1) : void { }
            public function sendEscortCanEnter() : void { }
            public function sendEscortEnterOrLeaveScene(isEnter:Boolean) : void { }
            public function sendPeerID(zoneID:int, userID:int, peerID:String) : void { }
            public function exploreMagicStone(type:int, isBind:Boolean, count:int = 1) : void { }
            public function getMagicStoneScore() : void { }
            public function convertMgStoneScore(goodsId:int, bind:Boolean = true, count:int = 1) : void { }
            public function moveMagicStone(sourcePlace:int, targetPlace:int) : void { }
            public function lockMagicStone(place:int) : void { }
            public function updateMagicStone(pSlots:Array) : void { }
            public function sortMgStoneBag(array:Array, startPlace:int) : void { }
            public function updateRemainCount() : void { }
            public function updateConsumeRank() : void { }
            public function updateRechargeRank() : void { }
            public function cooking(type:int) : void { }
            public function cookingGetAward(value:int) : void { }
            public function updateCookingCountByTime() : void { }
            public function updateDrgnBoatBuildInfo(id:int = 0) : void { }
            public function commitDrgnBoatMaterial(stage:int) : void { }
            public function helpToBuildDrgnBoat(id:int) : void { }
            public function broadcastMissileMC() : void { }
            public function enterMagpieBridge() : void { }
            public function magpieRollDice() : void { }
            public function buyMagpieCount(num:int, isBind:Boolean) : void { }
            public function refreshMagpieView() : void { }
            public function exitMagpieView() : void { }
            public function sendCryptBossFight(id:int, star:int) : void { }
            public function sendGetShopBuyLimitedCount() : void { }
            public function requestRescueItemInfo() : void { }
            public function requestRescueFrameInfo(sceneId:int = 0) : void { }
            public function sendRescueChallenge(sceneId:int) : void { }
            public function sendRescueCleanCD(isBind:Boolean, sceneId:int) : void { }
            public function sendRescueBuyBuff(type:int, count:int, isBind:Boolean) : void { }
            public function useRescueKingBless() : void { }
            public function getRescuePrize(sceneId:int, index:int) : void { }
            public function enterOrLeaveInsectScene(flag:int, point:Point = null) : void { }
            public function sendFightWithInsect(pMonsterID:int) : void { }
            public function sendInsectSceneMove(endX:int, endY:int, path:String) : void { }
            public function updateInsectInfo() : void { }
            public function updateInsectAreaRank() : void { }
            public function updateInsectAreaSelfInfo() : void { }
            public function updateInsectLocalRank() : void { }
            public function updateInsectLocalSelfInfo() : void { }
            public function getInsectPrize(templateId:int) : void { }
            public function requestCakeStatus() : void { }
            public function requestInsectWhistleUse(templateID:int) : void { }
            public function requestInsectWhistleBuy(goodId:int, isBind:Boolean) : void { }
            public function showHideTitleState(flag:Boolean) : void { }
            public function sendEnchant(isUpGrade:Boolean) : void { }
            public function getNationDayInfo() : void { }
            public function exchangeNationalGoods(id:int) : void { }
            public function getHalloweenViewInfo() : void { }
            public function getHalloweenExchangeViewInfo() : void { }
            public function getHalloweenExchange(index:int, count:int = 1) : void { }
            public function getHalloweenSetExchange() : void { }
            public function getHalloweenCandyNum() : void { }
            public function requestRookieRankInfo() : void { }
            public function sendBuyLevelFund(isBind:Boolean, buyType:int) : void { }
            public function sendGetLevelFundAward(level:int) : void { }
            public function sendOpenDailyView() : void { }
            public function sendForgeSuit(value:int) : void { }
            public function getHomeTempleLevel() : void { }
            public function setHomeTempleSelectIndex(index:int) : void { }
            public function setHomeTempleImmolation(id:int, flag:Boolean) : void { }
            public function wishingTreeSendWish(count:int) : void { }
            public function wishingTreeUpdateFrame() : void { }
            public function arrange(useID:int) : void { }
            public function enterTreasure() : void { }
            public function startTreasure() : void { }
            public function endTreasure() : void { }
            public function doTreasure(pos:int) : void { }
            public function wishingTreeGetReward(index:int) : void { }
            public function wishingTreeGetRecord() : void { }
            public function enterPyramid() : void { }
            public function getVipIntegralShopLimit() : void { }
            public function buyVipIntegralShopGoods(id:int, num:int) : void { }
            public function uploadDraftStyle(style:String, color:String) : void { }
            public function getPlayerSpecialProperty(type:int) : void { }
            public function sendDraftVoteTicket(num:int, styleId:int) : void { }
            public function getToyMachineInfo() : void { }
            public function sendToyMachineReward(index:int, count:int, isPay:Boolean, isBind:Boolean) : void { }
            public function happyRechargeEnter() : void { }
            public function happyRechargeStartLottery() : void { }
            public function happyRechargeExchange(count:int, itemId:int) : void { }
            public function happyRechargeQuestGetItem(type:int = 2) : void { }
            public function sendMemoryGameInfo() : void { }
            public function sendMemoryGameTurnover(index:int) : void { }
            public function sendMemoryGameReset(isBand:Boolean, isFree:Boolean = false) : void { }
            public function sendMemoryGameBuy(value:int, isBand:Boolean) : void { }
            public function sendMemoryGameGetReward(id:int) : void { }
            public function sendGuardCoreLevelUp() : void { }
            public function sendGuardCoreEquip(id:int) : void { }
            public function getVipAndMerryInfo(type:int) : void { }
            public function sendEnterGame() : void { }
            public function sendYGBuyGoods(num:int) : void { }
            public function sendLuckDrawGo() : void { }
            public function makeNewYearRice(type:int, roomTyple:int, arr:Array) : void { }
            public function sendCheckNewYearRiceInfo() : void { }
            public function sendCheckMakeNewYearFood() : void { }
            public function sendNewYearRiceOpen(playerNum:int) : void { }
            public function sendExitYearFoodRoom() : void { }
            public function sendInviteYearFoodRoom(isInvite:Boolean, playerID:int, isPublish:Boolean = false) : void { }
            public function sendQuitNewYearRiceRoom(playerID:int) : void { }
            public function clickAnotherDimensionEnter() : void { }
            public function clickAnotherDimenZhanling(pos:int) : void { }
            public function clickAnotherDimenSearch() : void { }
            public function clickAnotherDimenUpgrade(type:int, count:int) : void { }
            public function treasurePuzzle_enter() : void { }
            public function treasurePuzzle_seeReward() : void { }
            public function treasurePuzzle_getReward(id:int) : void { }
            public function treasurePuzzle_savePlayerInfo(name:String, phoneNum:String, address:String, id:int) : void { }
            public function treasurePuzzle_usePice(place:int, num:int = 1) : void { }
            public function petIslandInit(type:int) : void { }
            public function redEnvelopeListInfo() : void { }
            public function sendRedEnvelope(type:int) : void { }
            public function getRedEnvelope(id:int) : void { }
            public function redEnvelopeInfo(id:int) : void { }
            public function buyLotteryTicket(gameIndex:int, arr:Array) : void { }
            public function updataLotteryPool() : void { }
            public function getLotteryPrizeInfo() : void { }
            public function sendSignMsg(msg:String) : void { }
            public function petIslandBuyBlood(useSkillType:int) : void { }
            public function petIslandPlay(type:int, socre:int, bol:Boolean = false) : void { }
            public function sendEntertainment() : void { }
            public function buyEntertainment(bol:Boolean = false) : void { }
            public function petIslandPrize(step:int) : void { }
            public function eatPetsHandler(typeChoose:int, typeUse:int, count:int, petsArr:Array) : void { }
            public function sendCheckMagicStoneNumber() : void { }
            public function sendOpenDeed(type:int, playerId:int, msg:String, bool:Boolean) : void { }
            public function sendUseItemDeed(place:int, bagType:int) : void { }
            public function prayIndianaEnter() : void { }
            public function prayIndianaLottery() : void { }
            public function prayIndianaGoodsRefresh() : void { }
            public function prayIndianaPray($type:int, $initx:Number = 0.0, $targetx:Number = 0.0, $value:Number = 0.0) : void { }
            public function sendGetCSMTimeBox() : void { }
            public function sendLuckyStarEnter() : void { }
            public function sendLuckyStarClose() : void { }
            public function sendLuckyStarTurnComplete() : void { }
            public function sendLuckyStarTurn() : void { }
            public function enterGodsRoads() : void { }
            public function getGodsRoadsAwards(type:int, para:int) : void { }
            public function sendChickActivationOpenKey(strKey:String) : void { }
            public function sendChickActivationGetAward(index:int, levelIndex:int) : void { }
            public function sendChickActivationQuery() : void { }
            public function DDPlayEnter() : void { }
            public function DDPlayStart() : void { }
            public function DDPlayExchange(num:int) : void { }
            public function sendUseEveryDayGiftRecord(templateID:int, itemID:int, index:int) : void { }
            public function openMagicLib(type:int, pos:int) : void { }
            public function magicLibLevelUp(type:int, count:int) : void { }
            public function magicLibFreeGet(count:int) : void { }
            public function magicLibChargeGet(count:int) : void { }
            public function magicOpenDepot(pos:int, bol:Boolean) : void { }
            public function magicboxExtraction(id:int, counts:int = 1) : void { }
            public function magicboxFusion(id:int, counts:int = 1, value:Boolean = false) : void { }
            public function zodiacRolling() : void { }
            public function zodiacGetAward(questID:int) : void { }
            public function zodiacGetAwardAll() : void { }
            public function zodiacAddCounts(bol:Boolean) : void { }
            public function enterSuperWinner() : void { }
            public function rollDiceInSuperWinner() : void { }
            public function outSuperWinner() : void { }
            public function witchBlessing_enter(num:int = 0) : void { }
            public function sendWitchBless(num:int, boo:Boolean = false) : void { }
            public function sendWitchGetAwards(num:int, boo:Boolean = false) : void { }
            public function sevenDayTarget_enter(ishall:Boolean) : void { }
            public function newPlayerReward_enter() : void { }
            public function sevenDayTarget_getReward(qustionID:int) : void { }
            public function newPlayerReward_getReward(qustionID:int) : void { }
            public function sendHorseRaceItemUse(gameID:int, bufftype:int, useID:int, targetID:int) : void { }
            public function sendHorseRaceItemUse2(gameID:int, useId:int) : void { }
            public function sendHorseRaceEnd(gameID:int, useId:int) : void { }
            public function buyHorseRaceCount() : void { }
            public function sendBoguAdventureEnter() : void { }
            public function sendBoguAdventureWalkInfo(type:int, index:int = 0, bol:Boolean = true) : void { }
            public function sendBoguAdventureUpdateGame(type:int, bol:Boolean = true) : void { }
            public function sendBoguAdventureAcquireAward(type:int) : void { }
            public function sendOutBoguAdventure() : void { }
            public function sendGuildMemberWeekStarEnter() : void { }
            public function sendGuildMemberWeekStarClose() : void { }
            public function sendGuildMemberWeekAddRanking(data:Array) : void { }
            public function sendDaySign(date:Date) : void { }
            public function sendGetCardSoul() : void { }
            public function sendGrowthPackageOpen(bol:Boolean) : void { }
            public function sendGrowthPackageGetItems($index:int) : void { }
            public function sendFastAuctionBugle(id:int) : void { }
            public function queryDDQiYuanMyInfo() : void { }
            public function queryDDQiYuanRankRewardConfig() : void { }
            public function sendDDQiYuanOfferTimes(type:int, useBindQuan:Boolean) : void { }
            public function sendDDQiYuanOpenTreasureBox(useBindQuan:Boolean) : void { }
            public function queryDDQiYuanAreaRank(type:int) : void { }
            public function queryDDQiYuanTowerTask() : void { }
            public function getDDQiYuanTowerTaskReward(type:int) : void { }
            public function getDDQiYuanJoinReward() : void { }
            public function sendAngelInvestmentUpdate() : void { }
            public function loginDeviceSendUaToCheck(b:Boolean) : void { }
            public function loginDeviceGetDownReward() : void { }
            public function loginDeviceGetDailyReward() : void { }
            public function sendAngelInvestmentBuyOne($id:int, $isBind:Boolean = false) : void { }
            public function sendAngelInvestmentGainOne($id:int) : void { }
            public function sendAngelInvestmentGainAll() : void { }
            public function sendAngelInvestmentBuyAll($isBind:Boolean = false) : void { }
            public function sendBombTurnTableLottery() : void { }
            public function requestBombTurnTableData() : void { }
            public function sendWasteRecycleStartTurn() : void { }
            public function sendWasteRecycleEnter() : void { }
            public function sendWasteRecycleGoods(count:int = 1) : void { }
            public function queryOnlineRewardInfo() : void { }
            public function getOnlineReward() : void { }
            public function queryOnlineRewardBoxConfig() : void { }
            public function queryConsortionCallBackInfo() : void { }
            public function getConsortionCallBackAward(awardID:int) : void { }
            public function BuyCallFund() : void { }
            public function getCallFund() : void { }
            public function queryCallFundInfo() : void { }
            public function buyCallLotteryDrawGood(type:int, cardIndex:int, isBind:Boolean) : void { }
            public function refreshCallLotteryDrawInfo(type:int) : void { }
            public function queryCallLotteryDrawGoods(type:int) : void { }
            public function inspire(type:int) : void { }
            public function exchangeScore(day:int, id:int, num:int) : void { }
            public function cityBattleInfo() : void { }
            public function cityBattleScore() : void { }
            public function cityBattleJoin(side:int) : void { }
            public function cityBattleRank() : void { }
            public function cityBattleExchange(day:int) : void { }
            public function sendGainOldPlayerGift() : void { }
            public function getSignBuff(power:int) : void { }
            public function enterDemonChiYouScene() : void { }
            public function getDemonChiYouOtherPlayerInfo() : void { }
            public function leaveDemonChiYouScene() : void { }
            public function buyDemonChiYouRoll(id:int) : void { }
            public function buyDemonChiYouShopItem(id:int) : void { }
            public function getDemonChiYouRankInfo() : void { }
            public function getDemonChiYouBossInfo() : void { }
            public function getDemonChiYouShopInfo() : void { }
            public function requestCardAchievement() : void { }
            public function sendCardAchievementType(type:int) : void { }
            public function sendDDTKingGradeInfo() : void { }
            public function sendDDTKingGradeReset(isAll:Boolean, type:int) : void { }
            public function sendDDTKingGradeUp(type:int) : void { }
            public function sendPetsAwaken() : void { }
            public function getConsortiaDomainOtherPlayerInfo() : void { }
            public function leaveConsortiaDomainScene() : void { }
            public function getConsortiaDomainMonsterInfoInFight() : void { }
            public function getConsortiaDomainBuildInfoInFight() : void { }
            public function getConsortiaDomainConsortiaInfo() : void { }
            public function sendConsortiaDomainMove(pathArr:Array) : void { }
            public function sendConsortiaDomainFight(livingId:int) : void { }
            public function sendConsortiaDomainActive() : void { }
            public function sendConsortiaDomainRepair(buildId:int) : void { }
            public function getConsortiaDomainKillInfo() : void { }
            public function getConsortiaDomainActiveState() : void { }
            public function getSevendayProgressCount() : void { }
            public function getConsortiaDomainBuildRepairInfo() : void { }
            public function sendQuestionAwardAnswer(data:String) : void { }
            public function requestAwardItem() : void { }
            public function sendRollDice(place:int) : void { }
            public function sendBombPos(gameType:int, vx:int, vy:int, isbomb:Boolean, data:Array, bombinfo:Array) : void { }
            public function sendHappyMiniGameActiveData() : void { }
            public function sendBombStart(gameType:int) : void { }
            public function sendBombEnterRoom(gameType:int) : void { }
            public function sendBombGameRank(gameType:int, rankType:int) : void { }
            public function sendBombGameOver() : void { }
            public function sendBombGameNext() : void { }
            public function sendConsortiaGuradOpenGuard(grade:int) : void { }
            public function sendConsortiaGuradLeaveScene() : void { }
            public function sendConsortiaGuradFight(bossID:int) : void { }
            public function sendConsortiaGuradRank() : void { }
            public function sendConsortiaGuradPlayerRevive(spend:Boolean) : void { }
            public function sendConsortiaGuradGameState() : void { }
            public function sendConsortiaGuradBuyBuff(level:int) : void { }
            public function sendRewardTaskQuestOfferInfo() : void { }
            public function sendRewardTaskRefreshQuest(value:Boolean = true) : void { }
            public function sendRewardTaskAddTimes(addTimes:Boolean = true) : void { }
            public function sendRewardTaskRefreshReward(multiple:Boolean = true) : void { }
            public function sendRewardTaskAcceptQuest(acceptQuest:Boolean = true) : void { }
            public function sendOpenAmuletBox(bagType:int, place:int, count:int = 1) : void { }
            public function sendAmuletActivate(place:int) : void { }
            public function sendAmuletSmash(list:Array) : void { }
            public function sendAmuletMove(oldPlace:int, target:int) : void { }
            public function sendAmuletLock(place:int) : void { }
            public function sendAmuletActivateReplace(value:Boolean) : void { }
            public function sendEquipAmuletBuyNum() : void { }
            public function sendEquipAmuletUpgrade(isAll:Boolean = false) : void { }
            public function sendEquipAmuletActivate(isBool:Boolean, list:Array) : void { }
            public function sendEquipAmuletBuyStive(bool:Boolean) : void { }
            public function sendEquipAmuletReplace(bool:Boolean) : void { }
            public function requestManualInitData() : void { }
            public function requestManualPageData(chapterID:int) : void { }
            public function sendManualPageActive(activeType:int, pageID:int, isBindMoney:Boolean = false) : void { }
            public function sendManualUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void { }
            public function sendIndiana(perId:int, count:int, isBind:Boolean = false) : void { }
            public function sendIndianaCode(perid:int, useid:int) : void { }
            public function sendIndianaEnterGame(perid:int) : void { }
            public function sendIndianaHistoryData() : void { }
            public function sendIndianaCurrentData(perid:int) : void { }
            public function sendHappyMiniGameRankDataList() : void { }
            public function rollGameDice() : void { }
            public function defendislandInfo(type:int) : void { }
            public function pvePowerBuffRefresh() : void { }
            public function pvePowerBuffGetBuff(index:int) : void { }
            public function sendEquipGhost() : void { }
            public function sendBankUpdate(type:int) : void { }
            public function sendBanksaveMoney(tempId:int, count:int) : void { }
            public function sendBankGetMoney(bankId:int, count:int) : void { }
            public function sendBankGetTaskComplete() : void { }
            public function addPlayerDressPay() : void { }
            public function sendUpdateUserCmd(type:int) : void { }
            public function sendDealStockOrFund(type:int, id:int, cnt:int, demandType:int, price:int) : void { }
            public function sendBuyLoan(cnt:int, demandType:int) : void { }
            public function sendStockSpecific(id:int, type:int, lastTime:int) : void { }
            public function sendUserStockAccountInfo() : void { }
            public function sendStockNews() : void { }
            public function sendStockAward(index:int) : void { }
            public function sendPersonalLimitShop(type:int) : void { }
            public function sendConsortionActiveTargetSchedule() : void { }
            public function sendConsortionActiveTagertStatus() : void { }
            public function sendConsortionActiveTagertReward(level:int) : void { }
            public function sendMinesArrange() : void { }
            public function sendDigHandler(floor:int) : void { }
            public function sendUpdataToolHandler(place:int, count:int) : void { }
            public function sendBuyHandler(id:int, num:int) : void { }
            public function sendExchangeHandler(id:int, num:int) : void { }
            public function sendMinesShopHandler() : void { }
            public function sendInitHandler() : void { }
            public function sendEquipmentLevelUpHandler(type:int, place:int, count:int) : void { }
            public function sendTeamChatTalk(id:int, content:String) : void { }
            public function sendRoomBordenItemUp(place:int) : void { }
            public function sendUseRoomBorden(type:Boolean, id:int) : void { }
            public function sendSellRoomBordan(id:int, place:int) : void { }
            public function sendTeamCreate(name:String, tag:String) : void { }
            public function sendTeamGetInfo(teamID:int) : void { }
            public function sendTeamInvite(userID:int) : void { }
            public function sendTeamInviteRepeal(userID:Number) : void { }
            public function sendTeamInviteApproval(userID:Number) : void { }
            public function sendTeamInviteAccept(userID:Number, teamID:Number) : void { }
            public function sendTeamCheckInput(isName:Boolean, value:String) : void { }
            public function sendTeamGetInviteList(id:int) : void { }
            public function sendTeamExpeleMember(id:int) : void { }
            public function sendTeamGetRecord(id:int) : void { }
            public function sendTeamGetActive(id:int) : void { }
            public function sendTeamGetSelfActive() : void { }
            public function sendTeamDonate(value:int) : void { }
            public function sendTeamExit() : void { }
            public function sendChangeTeamName(bagType:int, place:int, name:String, tag:String) : void { }
            public function sendConsortiaGuradBossRank(bossByte:int) : void { }
            public function sendTreasureRoomData() : void { }
            public function sendSubmitTransfer(status:int) : void { }
            public function sendUserAllDebris() : void { }
            public function sendOnOrOffChip(id:int, place:int) : void { }
            public function sendSellChips(chips:Array) : void { }
            public function sendHammerChip(id:int, cnt:int) : void { }
            public function sendCrystalList() : void { }
            public function sendTransferChip(id:int, proKey:int) : void { }
            public function sendOperationStatus(type:int, id:int) : void { }
            public function sendSaveEquipScheme(schemeID:int) : void { }
            public function sendSwitchEquipScheme(schemeID:int) : void { }
            public function sendAddEquipScheme() : void { }
            public function sendTreasureRoomReward(count:int, isPay:Boolean, isBind:Boolean) : void { }
            public function sendStopExpStorage(type:int) : void { }
            public function sendGetGourdExpStorage() : void { }
            public function sendDevilGetInfo() : void { }
            public function sendDevilTurnSacrifice(value:Boolean, count:int, isBand:Boolean = true) : void { }
            public function sendDevilTurnScoreConversion(id:int) : void { }
            public function sendDevilTurnBeadConversion(id:int) : void { }
            public function sendDevilTurnOpenBox(id:int) : void { }
            public function sendDevilTurnDiceStart(id:int) : void { }
            public function sendDevilTurnContinueDice(templateID:int, isBand:Boolean) : void { }
            public function sendDevilTurnGetBox(templateID:int) : void { }
            public function sendDevilTurnBoxExpire(templateID:int) : void { }
            public function sendDevilTurnBoxAbandon(templateID:int) : void { }
            public function sendDevilTurnUpdateJackpot() : void { }
            public function sendTeamCaptainTransfer(id:int) : void { }
            public function requestDreamLandData() : void { }
            public function sendBuyDreamLandCount(bol:Boolean) : void { }
            public function requestDreamLandRandData(pageNum:int, type:int) : void { }
            public function sendPetWashBone(place:int, hpLock:Boolean, attackLock:Boolean, defenceLock:Boolean, agilityLock:Boolean, luckLock:Boolean) : void { }
            public function getWorldcupInfo() : void { }
            public function chooseWorldcupTeam(team:int) : void { }
            public function clearWorldPrizeGuess() : void { }
            public function getWorldcupPrize(index:int) : void { }
            public function sendTotemUpGrade(totemPage:int) : void { }
   }}