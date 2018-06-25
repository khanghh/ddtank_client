package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.BreakInfo;
   import petsBag.view.item.PetSmallDetailItem;
   
   public class PetsMaxGradeBreakView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _petsBasicInfoView:PetsBasicInfoView;
      
      private var _petsImgVec:Vector.<PetSmallDetailItem>;
      
      private var selectList:Array;
      
      private var itemContainer:HBox;
      
      private var _bagCellBreak:FilterFrameText;
      
      private var _bagCellBg:Bitmap;
      
      private var _bagCellProtect:PetsAdvancedCell;
      
      private var _checkBoxProtect:SelectedCheckButton;
      
      private var _btnEatPets:SimpleBitmapButton;
      
      private var _petInfo:PlayerInfo;
      
      private var _txtBreakCurGradeInfo:FilterFrameText;
      
      private var _txtDetail:FilterFrameText;
      
      private var _txtWarnning:FilterFrameText;
      
      private var _petBreakFrame:PetsBreakAnimationFrame;
      
      private var sucTip:Bitmap;
      
      private var failTip:Bitmap;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var currentPage:int = 1;
      
      private var totalPage:int;
      
      public function PetsMaxGradeBreakView()
      {
         super();
         initView();
         PetsAdvancedManager.Instance.addEventListener("change",update);
         PetsBagManager.instance().petModel.addEventListener("change",onPetInfoChange);
      }
      
      protected function update(e:Event) : void
      {
         updateData();
      }
      
      protected function onPetInfoChange(e:Event) : void
      {
         if(_txtBreakCurGradeInfo == null)
         {
            return;
         }
         PetsBagManager.instance().petBreakInfoRequire();
      }
      
      protected function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         selectList = [];
         _bg = ComponentFactory.Instance.creatBitmap("petsBag.break.bg");
         _bg.x = 19;
         _bg.y = 80;
         addChild(_bg);
         _petsBasicInfoView = new PetsBasicInfoView();
         addChild(_petsBasicInfoView);
         _petsBasicInfoView.addEventListener("all_movie_complete",__allComplete);
         var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(petInfo != null)
         {
            _petsBasicInfoView && _petsBasicInfoView.setInfo(petInfo);
         }
         itemContainer = ComponentFactory.Instance.creatComponentByStylename("petsBag.petbreakItemContainer");
         itemContainer.x = 68;
         itemContainer.y = 365;
         itemContainer.spacing = 1;
         _petsImgVec = new Vector.<PetSmallDetailItem>();
         for(i = 0; i < 4; )
         {
            cell = new PetSmallDetailItem();
            cell.mouseChildren = false;
            cell.buttonMode = true;
            cell.useHandCursor = true;
            cell.addEventListener("click",onCellClick);
            _petsImgVec.push(itemContainer.addChild(cell));
            i++;
         }
         addChild(itemContainer);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.left");
         addChild(_leftBtn);
         PositionUtils.setPos(_leftBtn,"petsBag.button.leftPos");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.button.right");
         addChild(_rightBtn);
         PositionUtils.setPos(_rightBtn,"petsBag.button.rightPos");
         _leftBtn.addEventListener("click",__left);
         _rightBtn.addEventListener("click",__right);
         _bagCellBreak = ComponentFactory.Instance.creat("petsBag.break.infoTxt");
         _bagCellBreak.x = 470;
         _bagCellBreak.y = 344;
         _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",0,0);
         addChild(_bagCellBreak);
         _bagCellBg = ComponentFactory.Instance.creat("petsBag.risingStar.bagCellBg");
         addChild(_bagCellBg);
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = 11167;
         info = ItemManager.fill(info);
         _bagCellProtect = new PetsAdvancedCell();
         _bagCellProtect.x = 389;
         _bagCellProtect.y = 336;
         _bagCellProtect.info = info;
         _bagCellProtect.buyBtn.x = 16;
         _bagCellProtect.buyBtn.y = 38;
         addChild(_bagCellProtect);
         _bagCellBg.x = _bagCellProtect.x;
         _bagCellBg.y = _bagCellProtect.y;
         _bagCellProtect.addEventListener("pac_updated",onPetsCellUpdated);
         _checkBoxProtect = ComponentFactory.Instance.creatComponentByStylename("petsBag.break.UseProtectCheckBox");
         addChild(_checkBoxProtect);
         _checkBoxProtect.text = LanguageMgr.GetTranslation("ddt.pets.break.useProtected");
         _txtBreakCurGradeInfo = ComponentFactory.Instance.creatComponentByStylename("petsBag.break.infoTxt");
         _txtBreakCurGradeInfo.text = "";
         addChild(_txtBreakCurGradeInfo);
         _txtDetail = ComponentFactory.Instance.creatComponentByStylename("petsBag.break.DetailTxt");
         _txtDetail.text = LanguageMgr.GetTranslation("ddt.pets.break.detail");
         addChild(_txtDetail);
         _txtWarnning = ComponentFactory.Instance.creatComponentByStylename("petsBag.break.WarningTxt");
         _txtWarnning.text = LanguageMgr.GetTranslation("ddt.pets.break.warning");
         addChild(_txtWarnning);
         sucTip = ComponentFactory.Instance.creatBitmap("asset.pets.breakSucc");
         failTip = ComponentFactory.Instance.creatBitmap("asset.pets.breakFail");
         _btnEatPets = ComponentFactory.Instance.creat("petsBag.break.eatSimpleButton");
         addChild(_btnEatPets);
         _btnEatPets.addEventListener("click",onBtnEatClick);
         _btnEatPets.enable = false;
         _petBreakFrame = ComponentFactory.Instance.creatComponentByStylename("petsBag.breakFrame");
         PetsBagManager.instance().addEventListener("b_fail",onBreakResult);
         PetsBagManager.instance().addEventListener("b_succ",onBreakResult);
         PlayerManager.Instance.addEventListener("updatePet",onUpdatePet);
      }
      
      protected function onPetsCellUpdated(e:Event) : void
      {
         var breakInfo:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         var count:int = _bagCellProtect.getCount();
         var num:int = breakInfo.stoneNumber;
         _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",count,num);
      }
      
      private function __left(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         countTotalPage();
         currentPage = currentPage - 1 < 1?1:Number(currentPage - 1);
         updateData(currentPage);
      }
      
      private function __right(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         countTotalPage();
         currentPage = currentPage + 1 > totalPage?totalPage:currentPage + 1;
         updateData(currentPage);
      }
      
      protected function onBreakResult(e:Event) : void
      {
         e = e;
         onSucComplete = function():void
         {
            onSucEnd = function():void
            {
            };
            TweenMax.to(sucTip,1,{
               "delay":0.5,
               "y":150,
               "alpha":0,
               "onComplete":onSucEnd
            });
         };
         onFailComplete = function():void
         {
            onFailEnd = function():void
            {
            };
            TweenMax.to(failTip,1,{
               "delay":0.5,
               "y":150,
               "alpha":0,
               "onComplete":onFailEnd
            });
         };
         if(_bagCellBreak)
         {
            var breakInfo:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
            var count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11167);
            var num:int = breakInfo.stoneNumber;
            _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",count,num);
            _bagCellProtect.updateCount();
         }
         if(_petBreakFrame == null)
         {
            return;
         }
         var _loc3_:* = e.type;
         if("b_fail" !== _loc3_)
         {
            if("b_succ" !== _loc3_)
            {
               return;
            }
            _petBreakFrame.result(true);
            sucTip.x = 250;
            sucTip.y = 400;
            sucTip.alpha = 0;
            TweenMax.to(sucTip,1,{
               "y":250,
               "alpha":1,
               "onComplete":onSucComplete
            });
            LayerManager.Instance.addToLayer(sucTip,2);
         }
         else
         {
            _petBreakFrame.result(false);
            failTip.x = 250;
            failTip.y = 400;
            failTip.alpha = 0;
            TweenMax.to(failTip,1,{
               "y":250,
               "alpha":1,
               "onComplete":onFailComplete
            });
            LayerManager.Instance.addToLayer(failTip,2);
         }
      }
      
      protected function onCellClick(me:MouseEvent) : void
      {
         var petNumNeeded:int = 0;
         var alreadyOne:Boolean = false;
         var i:int = 0;
         var item:PetSmallDetailItem = me.target as PetSmallDetailItem;
         if(item.info == null)
         {
            return;
         }
         if(item.selected == false)
         {
            petNumNeeded = PetsBagManager.instance().petModel.currentPetBreakInfo.numPetsNeeded;
            alreadyOne = false;
            if(petNumNeeded == 1)
            {
               if(selectList.length == 1)
               {
                  return;
               }
            }
            else if(selectList.length + 1 > petNumNeeded)
            {
               return;
            }
         }
         item.selected = !item.selected;
         var obj:Object = {};
         if(item.selected)
         {
            obj.info = item.info;
            obj.starNum = item.getStarNum();
            obj.place = item.info.Place;
            selectList.push(obj);
         }
         else
         {
            i = 0;
            while(i < selectList.length)
            {
               if(selectList[i].place == item.info.Place)
               {
                  selectList.splice(i);
               }
               i++;
            }
         }
         if(selectList.length > 0)
         {
            _btnEatPets.enable = true;
         }
         else
         {
            _btnEatPets.enable = false;
         }
      }
      
      public function set btnEatPetsEnable(value:Boolean) : void
      {
         _btnEatPets.enable = value;
      }
      
      public function set valueOfTotalSelected(value:int) : void
      {
         if(selectList.length > 0)
         {
            _btnEatPets.enable = true;
         }
         else
         {
            _btnEatPets.enable = false;
         }
      }
      
      public function get valueOfTotalSelected() : int
      {
         return selectList.length;
      }
      
      public function get valueOfPetsImgVec() : Vector.<PetSmallDetailItem>
      {
         return _petsImgVec;
      }
      
      protected function useProtectHander(e:MouseEvent) : void
      {
      }
      
      protected function onBtnEatClick(e:MouseEvent) : void
      {
         var alertString:* = null;
         var alert:* = null;
         var alert2:* = null;
         SoundManager.instance.play("008");
         var breakInfo:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         var tagPetLevel:int = PetsBagManager.instance().petModel.currentPetInfo.Level;
         var levelNeeded:int = PetsBagManager.instance().petModel.currentPetBreakInfo.targetGrade;
         var isFighting:Boolean = petsToEatIsFighting();
         var breakGradeEnough:Boolean = getBreakGradeEnough(breakInfo);
         var numNeeded:int = breakInfo.numPetsNeeded;
         var numNeedSamSangStone:int = breakInfo.stoneNumber;
         var numSamSangStone:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11167);
         var numEatPetsSeletcted:int = getNumPetsToEatSelected();
         var useProtectStone:Boolean = _checkBoxProtect.selected;
         var petsStarsEnough:Boolean = getPetsStarsEnough(breakInfo);
         var petRiseStarsEver:Boolean = riseStarEver();
         if(tagPetLevel < levelNeeded)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.petLevel.NotEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(numEatPetsSeletcted < numNeeded)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.eatNum.NotEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(petsStarsEnough == false)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.stars.NotEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(numSamSangStone < numNeedSamSangStone)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.samsang.NotEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(isFighting)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.shoudnotFight");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(breakGradeEnough == false)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.breakGradeEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            return;
         }
         if(useProtectStone == true && getProtectStoneNumber() < 1)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.protectedNotEnough");
            MessageTipManager.getInstance().show(alertString,0,false,1);
            buyProtectStone();
            return;
         }
         if(petRiseStarsEver)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.starExpWaste");
            alert = AlertManager.Instance.simpleAlert("Cảnh cáo：",alertString,"O K","Hủy",false,true,false,1);
            alert.addEventListener("response",__onAlertRiseStarResponse);
            return;
         }
         if(useProtectStone == false)
         {
            alertString = LanguageMgr.GetTranslation("ddt.pets.break.sureToNotUseProtect");
            alert2 = AlertManager.Instance.simpleAlert("Cảnh cáo：",alertString,"O K","Hủy",false,true,false,1);
            alert2.addEventListener("response",__onAlertResponse);
            return;
         }
         showBreakFrame();
      }
      
      private function showBreakFrame() : void
      {
         LayerManager.Instance.addToLayer(_petBreakFrame,3,true,1);
         _petBreakFrame.show();
         _petBreakFrame._btnBreak.addEventListener("click",onBreakClick);
      }
      
      protected function __onAlertRiseStarResponse(event:FrameEvent) : void
      {
         var useProtectStone:Boolean = false;
         var alertString:* = null;
         var alert1:* = null;
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertRiseStarResponse);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               alert.dispose();
               break;
            case 2:
            case 3:
            case 4:
               alert.dispose();
               useProtectStone = _checkBoxProtect.selected;
               if(useProtectStone == false)
               {
                  alertString = LanguageMgr.GetTranslation("ddt.pets.break.sureToNotUseProtect");
                  alert1 = AlertManager.Instance.simpleAlert("Cảnh cáo：",alertString,"O K","Hủy",false,false,false,1);
                  alert1.addEventListener("response",__onAlertResponse);
                  break;
               }
               showBreakFrame();
               break;
         }
      }
      
      protected function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               alert.dispose();
               break;
            case 2:
            case 3:
            case 4:
               showBreakFrame();
               alert.dispose();
         }
      }
      
      private function getProtectStoneNumber() : int
      {
         var number:int = 0;
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         number = bagInfo.getItemCountByTemplateId(11168);
         return number;
      }
      
      private function buyProtectStone() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var shopInfo:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(11168,1);
         var quickBuyFrame:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         quickBuyFrame.setData(shopInfo.TemplateID,shopInfo.GoodsID,shopInfo.AValue1);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      protected function onBreakClick(e:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _petBreakFrame._btnBreak.enable = false;
         var tagPet:int = PetsBagManager.instance().petModel.currentPetInfo.Place;
         var useProtect:Boolean = _checkBoxProtect.selected;
         var eatPosList:Array = [];
         for(i = 0; i < selectList.length; )
         {
            eatPosList.push(selectList[i].place);
            i++;
         }
         if(eatPosList.length < 2)
         {
            eatPosList.push(-1);
         }
         PetsBagManager.instance().petBreakBtnClick(tagPet,useProtect,eatPosList);
      }
      
      private function getNumPetsToEatSelected() : int
      {
         var i:int = 0;
         var num:int = 0;
         for(i = 0; i < selectList.length; )
         {
            num++;
            i++;
         }
         return num;
      }
      
      private function getPetsStarsEnough(breakInfo:BreakInfo) : Boolean
      {
         var i:int = 0;
         var enough:Boolean = true;
         for(i = 0; i < selectList.length; )
         {
            if(selectList[i].starNum < breakInfo.star1)
            {
               enough = false;
               break;
            }
            i++;
         }
         return enough;
      }
      
      private function petsToEatIsFighting() : Boolean
      {
         var i:int = 0;
         var isFighting:Boolean = false;
         for(i = 0; i < selectList.length; )
         {
            if(selectList[i].info.IsEquip)
            {
               isFighting = true;
               break;
            }
            i++;
         }
         return isFighting;
      }
      
      private function getBreakGradeEnough(breakInfo:BreakInfo) : Boolean
      {
         var i:int = 0;
         var breakGradeEnough:Boolean = true;
         for(i = 0; i < selectList.length; )
         {
            if(selectList[i].info.Level < breakInfo.breakGrade1)
            {
               breakGradeEnough = false;
               break;
            }
            i++;
         }
         return breakGradeEnough;
      }
      
      private function riseStarEver() : Boolean
      {
         var i:int = 0;
         var petInfo:* = null;
         for(i = 0; i < selectList.length; )
         {
            petInfo = selectList[i].info;
            if(petInfo.currentStarExp > 0)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      protected function onUpdatePet(e:CEvent) : void
      {
         countTotalPage();
         updateData();
      }
      
      private function countTotalPage() : void
      {
         var totalPet:int = 0;
         var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var breakInfo:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         _petInfo = PlayerManager.Instance.Self;
         var _loc6_:int = 0;
         var _loc5_:* = _petInfo.pets;
         for each(var pt in _petInfo.pets)
         {
            if(pt.Place != petInfo.Place && pt.StarLevel >= breakInfo.star1 && pt.Level >= breakInfo.breakGrade1)
            {
               totalPet++;
            }
         }
         totalPage = Math.ceil(totalPet / 4);
      }
      
      private function updateData(page:int = 1) : void
      {
         var i:int = 0;
         var j:int = 0;
         var totalPet:int = 0;
         var p:int = 0;
         var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(petInfo == null)
         {
            return;
         }
         if(_petsImgVec == null)
         {
            return;
         }
         _petsBasicInfoView && _petsBasicInfoView.setInfo(petInfo);
         var breakInfo:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         _petInfo = PlayerManager.Instance.Self;
         var _loc13_:int = 0;
         var _loc12_:* = _petsImgVec;
         for each(var petItem in _petsImgVec)
         {
            petItem.info = null;
            petItem.setNameTxt("");
            petItem.setGradeTxt("0");
            petItem.setStarNum(0);
         }
         if(breakInfo.targetGrade != -1)
         {
            i = 0;
            j = 0;
            var _loc15_:int = 0;
            var _loc14_:* = _petInfo.pets;
            for each(var pt in _petInfo.pets)
            {
               if(pt.Place != petInfo.Place && pt.StarLevel >= breakInfo.star1 && pt.Level >= breakInfo.breakGrade1)
               {
                  totalPet++;
                  j++;
                  if(j <= 4 * page && j > 4 * (page - 1))
                  {
                     _petsImgVec[i].info = pt;
                     _petsImgVec[i].setNameTxt(pt.Name);
                     _petsImgVec[i].setGradeTxt(pt.Level.toString());
                     _petsImgVec[i].setStarNum(pt.StarLevel);
                     _petsImgVec[i].selected = false;
                     for(p = 0; p < selectList.length; )
                     {
                        if(pt.Place == selectList[p].place)
                        {
                           _petsImgVec[i].selected = true;
                           break;
                        }
                        p++;
                     }
                     i++;
                  }
               }
            }
            totalPage = Math.ceil(totalPet / 4);
         }
         _bagCellProtect.updateCount();
         var count:int = _bagCellProtect.getCount();
         var num:int = breakInfo.stoneNumber;
         _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",count,num);
         if(breakInfo.targetGrade == -1)
         {
            _txtBreakCurGradeInfo.text = LanguageMgr.GetTranslation("ddt.pets.break.fullGrade");
         }
         else
         {
            _txtBreakCurGradeInfo.text = LanguageMgr.GetTranslation("ddt.pets.break.breakCurGradeInfo",breakInfo.targetGrade,breakInfo.numPetsNeeded,breakInfo.breakGrade1,breakInfo.star1);
         }
      }
      
      protected function __allComplete(event:Event) : void
      {
         PetsAdvancedControl.Instance.isAllMovieComplete = true;
         PetsAdvancedControl.Instance.frame.enableBtn = true;
      }
      
      public function dispose() : void
      {
         PetsAdvancedManager.Instance.removeEventListener("change",update);
         PetsBagManager.instance().petModel.removeEventListener("change",onPetInfoChange);
         PetsBagManager.instance().removeEventListener("b_fail",onBreakResult);
         PetsBagManager.instance().removeEventListener("b_succ",onBreakResult);
         PlayerManager.Instance.removeEventListener("updatePet",onUpdatePet);
         _leftBtn.removeEventListener("click",__left);
         _rightBtn.removeEventListener("click",__right);
         _btnEatPets.removeEventListener("click",onBtnEatClick);
         _bagCellProtect.removeEventListener("pac_updated",onPetsCellUpdated);
         _petsBasicInfoView.removeEventListener("all_movie_complete",__allComplete);
         _bg = null;
         if(_petsBasicInfoView != null)
         {
            ObjectUtils.disposeObject(_petsBasicInfoView);
            _petsBasicInfoView = null;
         }
         if(_petsImgVec != null)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _petsImgVec;
            for each(var item in _petsImgVec)
            {
               ObjectUtils.disposeObject(item);
            }
            _petsImgVec.length = 0;
            _petsImgVec = null;
         }
         if(itemContainer != null)
         {
            ObjectUtils.disposeObject(itemContainer);
            itemContainer = null;
         }
         if(_bagCellBreak != null)
         {
            ObjectUtils.disposeObject(_bagCellBreak);
            _bagCellBreak = null;
         }
         _bagCellBg = null;
         if(_bagCellProtect != null)
         {
            ObjectUtils.disposeObject(_bagCellProtect);
            _bagCellProtect = null;
         }
         if(_checkBoxProtect != null)
         {
            ObjectUtils.disposeObject(_checkBoxProtect);
            _checkBoxProtect = null;
         }
         if(_btnEatPets != null)
         {
            ObjectUtils.disposeObject(_btnEatPets);
            _btnEatPets = null;
         }
         if(_txtBreakCurGradeInfo != null)
         {
            ObjectUtils.disposeObject(_txtBreakCurGradeInfo);
            _txtBreakCurGradeInfo = null;
         }
         if(_txtDetail != null)
         {
            ObjectUtils.disposeObject(_txtDetail);
            _txtDetail = null;
         }
         if(_txtWarnning != null)
         {
            ObjectUtils.disposeObject(_txtWarnning);
            _txtWarnning = null;
         }
         if(_petBreakFrame != null)
         {
            ObjectUtils.disposeObject(_petBreakFrame);
            _petBreakFrame = null;
         }
      }
   }
}

interface IEatState
{
    
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed2PetsClickSelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed2PetsClickSelected($view:PetsMaxGradeBreakView)
   {
      super();
      view = $view;
   }
   
   public function onClicked(me:MouseEvent) : void
   {
      var item:PetSmallDetailItem = me.target as PetSmallDetailItem;
      item.selected = false;
      view.valueOfTotalSelected--;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed2PetsClickUnelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed2PetsClickUnelected($view:PetsMaxGradeBreakView)
   {
      super();
      view = $view;
   }
   
   public function onClicked(me:MouseEvent) : void
   {
      var item:PetSmallDetailItem = me.target as PetSmallDetailItem;
      if(view.valueOfTotalSelected > 1)
      {
         return;
      }
      item.selected = true;
      view.valueOfTotalSelected++;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickUnselected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickUnselected($view:PetsMaxGradeBreakView)
   {
      super();
      view = $view;
   }
   
   public function onClicked(me:MouseEvent) : void
   {
      var i:int = 0;
      var item:PetSmallDetailItem = me.target as PetSmallDetailItem;
      var len:int = view.valueOfPetsImgVec.length;
      for(i = 0; i < len; )
      {
         view.valueOfPetsImgVec[i].selected = false;
         i++;
      }
      item.selected = true;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickSelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickSelected($view:PetsMaxGradeBreakView)
   {
      super();
      view = $view;
   }
   
   public function onClicked(me:MouseEvent) : void
   {
      var item:PetSmallDetailItem = me.target as PetSmallDetailItem;
      item.selected = false;
      view.valueOfTotalSelected--;
   }
}
