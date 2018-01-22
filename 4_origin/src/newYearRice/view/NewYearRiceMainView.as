package newYearRice.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import newYearRice.NewYearRiceManager;
   import road7th.comm.PackageIn;
   
   public class NewYearRiceMainView extends Frame
   {
      
      public static const DINNER:int = 0;
      
      public static const BANQUET:int = 1;
      
      public static const HAN:int = 2;
       
      
      private var _openFrameView:NewYearRiceOpenFrameView;
      
      private var _main:MovieClip;
      
      private var _dinnerSelectedBtn:SelectedButton;
      
      private var _banquetSelectedBtn:SelectedButton;
      
      private var _hanSelectedBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _materialsBg:Bitmap;
      
      private var _rewardBg:Bitmap;
      
      private var _makeBtn:BaseButton;
      
      private var _materialsNum_1:FilterFrameText;
      
      private var _materialsNum_2:FilterFrameText;
      
      private var _materialsNum_3:FilterFrameText;
      
      private var _materialsNum_4:FilterFrameText;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _currentNum:Array;
      
      private var _maxNum:Array;
      
      private var _helpBtn:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _selfInfo:SelfInfo;
      
      private var _price:int;
      
      private var _roomType:int;
      
      private var _psTxt:FilterFrameText;
      
      private var _alert1:BaseAlerFrame;
      
      private var _alert:BaseAlerFrame;
      
      private var _materialsArr:Array;
      
      public function NewYearRiceMainView()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
         addEvnets();
      }
      
      private function initView() : void
      {
         NewYearRiceManager.IsOpenFrame = false;
         _main = ClassUtils.CreatInstance("asset.newYearRice.view") as MovieClip;
         PositionUtils.setPos(_main,"asset.newYearRice.view.pos");
         addToContent(_main);
         _dinnerSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.dinnerSelectedBtn");
         addToContent(_dinnerSelectedBtn);
         _banquetSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.banquetSelectedBtn");
         addToContent(_banquetSelectedBtn);
         _hanSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.hanSelectedBtn");
         addToContent(_hanSelectedBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_dinnerSelectedBtn);
         _btnGroup.addSelectItem(_banquetSelectedBtn);
         _btnGroup.addSelectItem(_hanSelectedBtn);
         _btnGroup.selectIndex = 0;
         _materialsBg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.MaterialsTxtBG");
         addToContent(_materialsBg);
         showMaterials();
         _materialsNum_1 = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.materialsNum_1");
         _materialsNum_2 = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.materialsNum_2");
         _materialsNum_3 = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.materialsNum_3");
         _materialsNum_4 = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.materialsNum_4");
         addToContent(_materialsNum_1);
         addToContent(_materialsNum_2);
         addToContent(_materialsNum_3);
         addToContent(_materialsNum_4);
         _psTxt = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.psTxt");
         _psTxt.htmlText = LanguageMgr.GetTranslation("NewYearRiceMainView.psTxtLG");
         addToContent(_psTxt);
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.RewardBg");
         addToContent(_rewardBg);
         _makeBtn = ComponentFactory.Instance.creat("NewYearRiceMainView.makeBtn");
         addToContent(_makeBtn);
         _helpBtn = ComponentFactory.Instance.creat("NewYearRiceMainView.helpBtn");
         addToContent(_helpBtn);
         if(NewYearRiceManager.instance.model.yearFoodInfo > 0)
         {
            SocketManager.Instance.out.sendCheckMakeNewYearFood();
            return;
         }
         updateView(_btnGroup.selectIndex);
      }
      
      private function addEvnets() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__changeHandler);
         _makeBtn.addEventListener("click",__makeBtnHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         NewYearRiceManager.instance.addEventListener("yearFoodCook",__yearFoodCook);
         NewYearRiceManager.instance.addEventListener("yearFoodEnter",__yearFoodEnter);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _makeBtn.removeEventListener("click",__makeBtnHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
         NewYearRiceManager.instance.removeEventListener("yearFoodCook",__yearFoodCook);
         NewYearRiceManager.instance.removeEventListener("yearFoodEnter",__yearFoodEnter);
      }
      
      private function __yearFoodCook(param1:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.sendCheckMakeNewYearFood();
      }
      
      private function __yearFoodEnter(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _roomType = _loc2_.readInt();
         _openFrameView = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.NewYearRiceOpenView");
         _openFrameView.setViewFrame(_roomType);
         _openFrameView.roomPlayerItem(PlayerManager.Instance.Self.ID);
         LayerManager.Instance.addToLayer(_openFrameView,2,true,2);
         dispose();
      }
      
      private function __changeHandler(param1:Event) : void
      {
         updateView(_btnGroup.selectIndex);
      }
      
      private function updateView(param1:int = 0) : void
      {
         _currentNum = upDatafitCount(ServerConfigManager.instance.localYearFoodItems);
         switch(int(param1))
         {
            case 0:
               showDinnerView();
               break;
            case 1:
               showBanquetView();
               break;
            case 2:
               showHanView();
         }
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         _goodItemContainerAll = new Sprite();
         _goodItemContainerAll.x = 18;
         _goodItemContainerAll.y = -29;
         showGoods(NewYearRiceManager.instance.model.itemInfoList);
      }
      
      private function showDinnerView() : void
      {
         _maxNum = ServerConfigManager.instance.localYearFoodItemsCount[0].toString().split(",");
         updateMaterialsText(_currentNum,_maxNum);
      }
      
      private function showBanquetView() : void
      {
         _maxNum = ServerConfigManager.instance.localYearFoodItemsCount[1].toString().split(",");
         updateMaterialsText(_currentNum,_maxNum);
      }
      
      private function showHanView() : void
      {
         _maxNum = ServerConfigManager.instance.localYearFoodItemsCount[2].toString().split(",");
         updateMaterialsText(_currentNum,_maxNum);
      }
      
      private function __makeBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_materialsArr.length > 0)
         {
            _loc3_ = "";
            _loc2_ = ServerConfigManager.instance.localYearFoodItemsPrices;
            _loc4_ = 0;
            while(_loc4_ < _materialsArr.length)
            {
               var _loc5_:* = _materialsArr[_loc4_].id;
               if(0 !== _loc5_)
               {
                  if(1 !== _loc5_)
                  {
                     if(2 !== _loc5_)
                     {
                        if(3 === _loc5_)
                        {
                           _loc3_ = _loc3_ + ("Hải Sản x" + _materialsArr[_loc4_].number + "  ");
                           _price = _price + int(_loc2_[_loc4_]) * int(_materialsArr[_loc4_].number);
                        }
                     }
                     else
                     {
                        _loc3_ = _loc3_ + ("Rượu Nước x" + _materialsArr[_loc4_].number + "  ");
                        _price = _price + int(_loc2_[_loc4_]) * int(_materialsArr[_loc4_].number);
                     }
                  }
                  else
                  {
                     _loc3_ = _loc3_ + ("Thịt x" + _materialsArr[_loc4_].number + "  ");
                     _price = _price + int(_loc2_[_loc4_]) * int(_materialsArr[_loc4_].number);
                  }
               }
               else
               {
                  _loc3_ = _loc3_ + ("Rau Cải x" + _materialsArr[_loc4_].number + "  ");
                  _price = _price + int(_loc2_[_loc4_]) * int(_materialsArr[_loc4_].number);
               }
               _loc4_++;
            }
            _alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceMainView.view.money",_loc3_,_price),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _alert1.addEventListener("response",__makeNewYearRice);
         }
         else
         {
            SocketManager.Instance.out.makeNewYearRice(0,_btnGroup.selectIndex,_materialsArr);
         }
      }
      
      private function __makeNewYearRice(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__makeNewYearRice);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.Money < _price)
            {
               _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _alert.moveEnable = false;
               _alert.addEventListener("response",_responseI);
               return;
            }
            SocketManager.Instance.out.makeNewYearRice(1,_btnGroup.selectIndex,_materialsArr);
         }
         _price = 0;
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function showMaterials() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = new Sprite();
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.newYearRice.MaterialsBG" + _loc4_);
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.newYearRice.MaterialsNumFrame");
            _loc2_.addChild(_loc3_);
            _loc2_.addChild(_loc1_);
            addToContent(_loc2_);
            PositionUtils.setPos(_loc2_,"NewYearRiceMainView.Materials" + _loc4_);
            _loc4_++;
         }
      }
      
      private function updateMaterialsText(param1:Array, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _materialsArr = [];
         var _loc4_:int = 0;
         _materialsNum_1.text = param1[0] + "/" + param2[0];
         _materialsNum_2.text = param1[1] + "/" + param2[1];
         _materialsNum_3.text = param1[2] + "/" + param2[2];
         _materialsNum_4.text = param1[3] + "/" + param2[3];
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            if(param1[_loc5_] >= param2[_loc5_])
            {
               switch(int(_loc5_))
               {
                  case 0:
                     _materialsNum_1.text = param1[0] + "/" + param2[0];
                     setTFStyle(_materialsNum_1);
                     break;
                  case 1:
                     _materialsNum_2.text = param1[1] + "/" + param2[1];
                     setTFStyle(_materialsNum_2);
                     break;
                  case 2:
                     _materialsNum_3.text = param1[2] + "/" + param2[2];
                     setTFStyle(_materialsNum_3);
                     break;
                  case 3:
                     _materialsNum_4.text = param1[3] + "/" + param2[3];
                     setTFStyle(_materialsNum_4);
               }
            }
            else
            {
               _loc3_ = {};
               _loc3_.number = param2[_loc5_] - param1[_loc5_];
               _loc3_.id = _loc5_;
               _materialsArr[_loc4_] = _loc3_;
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      public function upDatafitCount(param1:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc2_:BagInfo = _selfInfo.getBag(1);
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = _loc2_.getItemCountByTemplateId(param1[_loc5_]);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function getMaterialsPrice(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(param1[_loc4_]) as ItemTemplateInfo;
            _loc2_.push(_loc3_.Property3);
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function setTFStyle(param1:FilterFrameText) : void
      {
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = [16374016];
         param1.setTextFormat(_loc2_,0,param1.length);
      }
      
      private function showGoods(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc4_:Number = NaN;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc8_ = ComponentFactory.Instance.creatBitmap("asset.newYearRice.GoodsFrame");
            _loc4_ = _loc8_.width + 15;
            _loc4_ = _loc4_ * (int(_loc6_ % 6));
            _loc8_.x = _loc4_;
            _loc8_.y = 243;
            _loc7_ = ItemManager.Instance.getTemplateById(param1[_loc2_].TemplateID) as ItemTemplateInfo;
            if(param1[_loc2_].Quality != _btnGroup.selectIndex + 1)
            {
               _loc2_++;
            }
            else
            {
               _loc3_ = new InventoryItemInfo();
               ObjectUtils.copyProperties(_loc3_,_loc7_);
               _loc3_.ValidDate = param1[_loc2_].ValidDate;
               _loc3_.StrengthenLevel = param1[_loc2_].StrengthLevel;
               _loc3_.AttackCompose = param1[_loc2_].AttackCompose;
               _loc3_.DefendCompose = param1[_loc2_].DefendCompose;
               _loc3_.LuckCompose = param1[_loc2_].LuckCompose;
               _loc3_.AgilityCompose = param1[_loc2_].AgilityCompose;
               _loc3_.IsBinds = param1[_loc2_].IsBind;
               _loc3_.Count = param1[_loc2_].Count;
               _loc5_ = new BagCell(0,_loc3_,false);
               _loc5_.x = _loc4_ + 6;
               _loc5_.y = 249;
               _loc5_.setBgVisible(false);
               _goodItemContainerAll.addChild(_loc8_);
               _goodItemContainerAll.addChild(_loc5_);
               _loc2_++;
               _loc6_++;
            }
            _loc9_++;
         }
         addToContent(_goodItemContainerAll);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("NewYearRiceMainView.view.TexpView.helpTitle");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("NewYearRiceMainView.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(_alert1)
         {
            ObjectUtils.disposeObject(_alert1);
            _alert1 = null;
         }
         if(_alert)
         {
            ObjectUtils.disposeObject(_alert);
            _alert = null;
         }
      }
   }
}
