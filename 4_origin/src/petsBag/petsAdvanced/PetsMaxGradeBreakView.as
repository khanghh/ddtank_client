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
      
      protected function update(param1:Event) : void
      {
         updateData();
      }
      
      protected function onPetInfoChange(param1:Event) : void
      {
         if(_txtBreakCurGradeInfo == null)
         {
            return;
         }
         PetsBagManager.instance().petBreakInfoRequire();
      }
      
      protected function initView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         selectList = [];
         _bg = ComponentFactory.Instance.creatBitmap("petsBag.break.bg");
         _bg.x = 19;
         _bg.y = 80;
         addChild(_bg);
         _petsBasicInfoView = new PetsBasicInfoView();
         addChild(_petsBasicInfoView);
         _petsBasicInfoView.addEventListener("all_movie_complete",__allComplete);
         var _loc2_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc2_ != null)
         {
            _petsBasicInfoView && _petsBasicInfoView.setInfo(_loc2_);
         }
         itemContainer = ComponentFactory.Instance.creatComponentByStylename("petsBag.petbreakItemContainer");
         itemContainer.x = 68;
         itemContainer.y = 365;
         itemContainer.spacing = 1;
         _petsImgVec = new Vector.<PetSmallDetailItem>();
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc1_ = new PetSmallDetailItem();
            _loc1_.mouseChildren = false;
            _loc1_.buttonMode = true;
            _loc1_.useHandCursor = true;
            _loc1_.addEventListener("click",onCellClick);
            _petsImgVec.push(itemContainer.addChild(_loc1_));
            _loc4_++;
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
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = 11167;
         _loc3_ = ItemManager.fill(_loc3_);
         _bagCellProtect = new PetsAdvancedCell();
         _bagCellProtect.x = 389;
         _bagCellProtect.y = 336;
         _bagCellProtect.info = _loc3_;
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
      
      protected function onPetsCellUpdated(param1:Event) : void
      {
         var _loc4_:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         var _loc3_:int = _bagCellProtect.getCount();
         var _loc2_:int = _loc4_.stoneNumber;
         _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",_loc3_,_loc2_);
      }
      
      private function __left(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         countTotalPage();
         currentPage = currentPage - 1 < 1?1:Number(currentPage - 1);
         updateData(currentPage);
      }
      
      private function __right(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         countTotalPage();
         currentPage = currentPage + 1 > totalPage?totalPage:currentPage + 1;
         updateData(currentPage);
      }
      
      protected function onBreakResult(param1:Event) : void
      {
         e = param1;
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
      
      protected function onCellClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:PetSmallDetailItem = param1.target as PetSmallDetailItem;
         if(_loc2_.info == null)
         {
            return;
         }
         if(_loc2_.selected == false)
         {
            _loc4_ = PetsBagManager.instance().petModel.currentPetBreakInfo.numPetsNeeded;
            _loc5_ = false;
            if(_loc4_ == 1)
            {
               if(selectList.length == 1)
               {
                  return;
               }
            }
            else if(selectList.length + 1 > _loc4_)
            {
               return;
            }
         }
         _loc2_.selected = !_loc2_.selected;
         var _loc3_:Object = {};
         if(_loc2_.selected)
         {
            _loc3_.info = _loc2_.info;
            _loc3_.starNum = _loc2_.getStarNum();
            _loc3_.place = _loc2_.info.Place;
            selectList.push(_loc3_);
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < selectList.length)
            {
               if(selectList[_loc6_].place == _loc2_.info.Place)
               {
                  selectList.splice(_loc6_);
               }
               _loc6_++;
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
      
      public function set btnEatPetsEnable(param1:Boolean) : void
      {
         _btnEatPets.enable = param1;
      }
      
      public function set valueOfTotalSelected(param1:int) : void
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
      
      protected function useProtectHander(param1:MouseEvent) : void
      {
      }
      
      protected function onBtnEatClick(param1:MouseEvent) : void
      {
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc12_:* = null;
         SoundManager.instance.play("008");
         var _loc6_:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         var _loc2_:int = PetsBagManager.instance().petModel.currentPetInfo.Level;
         var _loc5_:int = PetsBagManager.instance().petModel.currentPetBreakInfo.targetGrade;
         var _loc16_:Boolean = petsToEatIsFighting();
         var _loc11_:Boolean = getBreakGradeEnough(_loc6_);
         var _loc15_:int = _loc6_.numPetsNeeded;
         var _loc13_:int = _loc6_.stoneNumber;
         var _loc9_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(11167);
         var _loc7_:int = getNumPetsToEatSelected();
         var _loc8_:Boolean = _checkBoxProtect.selected;
         var _loc14_:Boolean = getPetsStarsEnough(_loc6_);
         var _loc3_:Boolean = riseStarEver();
         if(_loc2_ < _loc5_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.petLevel.NotEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc7_ < _loc15_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.eatNum.NotEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc14_ == false)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.stars.NotEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc9_ < _loc13_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.samsang.NotEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc16_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.shoudnotFight");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc11_ == false)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.breakGradeEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            return;
         }
         if(_loc8_ == true && getProtectStoneNumber() < 1)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.protectedNotEnough");
            MessageTipManager.getInstance().show(_loc10_,0,false,1);
            buyProtectStone();
            return;
         }
         if(_loc3_)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.starExpWaste");
            _loc4_ = AlertManager.Instance.simpleAlert("Cảnh cáo：",_loc10_,"O K","Hủy",false,true,false,1);
            _loc4_.addEventListener("response",__onAlertRiseStarResponse);
            return;
         }
         if(_loc8_ == false)
         {
            _loc10_ = LanguageMgr.GetTranslation("ddt.pets.break.sureToNotUseProtect");
            _loc12_ = AlertManager.Instance.simpleAlert("Cảnh cáo：",_loc10_,"O K","Hủy",false,true,false,1);
            _loc12_.addEventListener("response",__onAlertResponse);
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
      
      protected function __onAlertRiseStarResponse(param1:FrameEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc2_:* = null;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__onAlertRiseStarResponse);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc3_.dispose();
               break;
            case 2:
            case 3:
            case 4:
               _loc3_.dispose();
               _loc5_ = _checkBoxProtect.selected;
               if(_loc5_ == false)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ddt.pets.break.sureToNotUseProtect");
                  _loc4_ = AlertManager.Instance.simpleAlert("Cảnh cáo：",_loc2_,"O K","Hủy",false,false,false,1);
                  _loc4_.addEventListener("response",__onAlertResponse);
                  break;
               }
               showBreakFrame();
               break;
         }
      }
      
      protected function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_.dispose();
               break;
            case 2:
            case 3:
            case 4:
               showBreakFrame();
               _loc2_.dispose();
         }
      }
      
      private function getProtectStoneNumber() : int
      {
         var _loc2_:int = 0;
         var _loc1_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         _loc2_ = _loc1_.getItemCountByTemplateId(11168);
         return _loc2_;
      }
      
      private function buyProtectStone() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(11168,1);
         var _loc2_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc2_.setData(_loc1_.TemplateID,_loc1_.GoodsID,_loc1_.AValue1);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      protected function onBreakClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _petBreakFrame._btnBreak.enable = false;
         var _loc2_:int = PetsBagManager.instance().petModel.currentPetInfo.Place;
         var _loc5_:Boolean = _checkBoxProtect.selected;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < selectList.length)
         {
            _loc3_.push(selectList[_loc4_].place);
            _loc4_++;
         }
         if(_loc3_.length < 2)
         {
            _loc3_.push(-1);
         }
         PetsBagManager.instance().petBreakBtnClick(_loc2_,_loc5_,_loc3_);
      }
      
      private function getNumPetsToEatSelected() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < selectList.length)
         {
            _loc1_++;
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getPetsStarsEnough(param1:BreakInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < selectList.length)
         {
            if(selectList[_loc3_].starNum < param1.star1)
            {
               _loc2_ = false;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function petsToEatIsFighting() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < selectList.length)
         {
            if(selectList[_loc2_].info.IsEquip)
            {
               _loc1_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getBreakGradeEnough(param1:BreakInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < selectList.length)
         {
            if(selectList[_loc3_].info.Level < param1.breakGrade1)
            {
               _loc2_ = false;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function riseStarEver() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < selectList.length)
         {
            _loc1_ = selectList[_loc2_].info;
            if(_loc1_.currentStarExp > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      protected function onUpdatePet(param1:CEvent) : void
      {
         countTotalPage();
         updateData();
      }
      
      private function countTotalPage() : void
      {
         var _loc3_:int = 0;
         var _loc4_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc1_:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         _petInfo = PlayerManager.Instance.Self;
         var _loc6_:int = 0;
         var _loc5_:* = _petInfo.pets;
         for each(var _loc2_ in _petInfo.pets)
         {
            if(_loc2_.Place != _loc4_.Place && _loc2_.StarLevel >= _loc1_.star1 && _loc2_.Level >= _loc1_.breakGrade1)
            {
               _loc3_++;
            }
         }
         totalPage = Math.ceil(_loc3_ / 4);
      }
      
      private function updateData(param1:int = 1) : void
      {
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc10_ == null)
         {
            return;
         }
         if(_petsImgVec == null)
         {
            return;
         }
         _petsBasicInfoView && _petsBasicInfoView.setInfo(_loc10_);
         var _loc5_:BreakInfo = PetsBagManager.instance().petModel.currentPetBreakInfo;
         _petInfo = PlayerManager.Instance.Self;
         var _loc13_:int = 0;
         var _loc12_:* = _petsImgVec;
         for each(var _loc9_ in _petsImgVec)
         {
            _loc9_.info = null;
            _loc9_.setNameTxt("");
            _loc9_.setGradeTxt("0");
            _loc9_.setStarNum(0);
         }
         if(_loc5_.targetGrade != -1)
         {
            _loc11_ = 0;
            _loc8_ = 0;
            var _loc15_:int = 0;
            var _loc14_:* = _petInfo.pets;
            for each(var _loc6_ in _petInfo.pets)
            {
               if(_loc6_.Place != _loc10_.Place && _loc6_.StarLevel >= _loc5_.star1 && _loc6_.Level >= _loc5_.breakGrade1)
               {
                  _loc7_++;
                  _loc8_++;
                  if(_loc8_ <= 4 * param1 && _loc8_ > 4 * (param1 - 1))
                  {
                     _petsImgVec[_loc11_].info = _loc6_;
                     _petsImgVec[_loc11_].setNameTxt(_loc6_.Name);
                     _petsImgVec[_loc11_].setGradeTxt(_loc6_.Level.toString());
                     _petsImgVec[_loc11_].setStarNum(_loc6_.StarLevel);
                     _petsImgVec[_loc11_].selected = false;
                     _loc4_ = 0;
                     while(_loc4_ < selectList.length)
                     {
                        if(_loc6_.Place == selectList[_loc4_].place)
                        {
                           _petsImgVec[_loc11_].selected = true;
                           break;
                        }
                        _loc4_++;
                     }
                     _loc11_++;
                  }
               }
            }
            totalPage = Math.ceil(_loc7_ / 4);
         }
         _bagCellProtect.updateCount();
         var _loc3_:int = _bagCellProtect.getCount();
         var _loc2_:int = _loc5_.stoneNumber;
         _bagCellBreak.text = LanguageMgr.GetTranslation("ddt.pets.break.stone",_loc3_,_loc2_);
         if(_loc5_.targetGrade == -1)
         {
            _txtBreakCurGradeInfo.text = LanguageMgr.GetTranslation("ddt.pets.break.fullGrade");
         }
         else
         {
            _txtBreakCurGradeInfo.text = LanguageMgr.GetTranslation("ddt.pets.break.breakCurGradeInfo",_loc5_.targetGrade,_loc5_.numPetsNeeded,_loc5_.breakGrade1,_loc5_.star1);
         }
      }
      
      protected function __allComplete(param1:Event) : void
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
            for each(var _loc1_ in _petsImgVec)
            {
               ObjectUtils.disposeObject(_loc1_);
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
   
   function StateNeed2PetsClickSelected(param1:PetsMaxGradeBreakView)
   {
      super();
      view = param1;
   }
   
   public function onClicked(param1:MouseEvent) : void
   {
      var _loc2_:PetSmallDetailItem = param1.target as PetSmallDetailItem;
      _loc2_.selected = false;
      view.valueOfTotalSelected--;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed2PetsClickUnelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed2PetsClickUnelected(param1:PetsMaxGradeBreakView)
   {
      super();
      view = param1;
   }
   
   public function onClicked(param1:MouseEvent) : void
   {
      var _loc2_:PetSmallDetailItem = param1.target as PetSmallDetailItem;
      if(view.valueOfTotalSelected > 1)
      {
         return;
      }
      _loc2_.selected = true;
      view.valueOfTotalSelected++;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickUnselected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickUnselected(param1:PetsMaxGradeBreakView)
   {
      super();
      view = param1;
   }
   
   public function onClicked(param1:MouseEvent) : void
   {
      var _loc4_:int = 0;
      var _loc2_:PetSmallDetailItem = param1.target as PetSmallDetailItem;
      var _loc3_:int = view.valueOfPetsImgVec.length;
      _loc4_ = 0;
      while(_loc4_ < _loc3_)
      {
         view.valueOfPetsImgVec[_loc4_].selected = false;
         _loc4_++;
      }
      _loc2_.selected = true;
   }
}

import flash.events.MouseEvent;
import petsBag.petsAdvanced.PetsMaxGradeBreakView;
import petsBag.view.item.PetSmallDetailItem;

class StateNeed1PetClickSelected implements IEatState
{
    
   
   private var view:PetsMaxGradeBreakView;
   
   function StateNeed1PetClickSelected(param1:PetsMaxGradeBreakView)
   {
      super();
      view = param1;
   }
   
   public function onClicked(param1:MouseEvent) : void
   {
      var _loc2_:PetSmallDetailItem = param1.target as PetSmallDetailItem;
      _loc2_.selected = false;
      view.valueOfTotalSelected--;
   }
}
