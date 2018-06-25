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
      
      private function __yearFoodCook(event:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.sendCheckMakeNewYearFood();
      }
      
      private function __yearFoodEnter(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _roomType = pkg.readInt();
         _openFrameView = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.NewYearRiceOpenView");
         _openFrameView.setViewFrame(_roomType);
         _openFrameView.roomPlayerItem(PlayerManager.Instance.Self.ID);
         LayerManager.Instance.addToLayer(_openFrameView,2,true,2);
         dispose();
      }
      
      private function __changeHandler(e:Event) : void
      {
         updateView(_btnGroup.selectIndex);
      }
      
      private function updateView($selectIndex:int = 0) : void
      {
         _currentNum = upDatafitCount(ServerConfigManager.instance.localYearFoodItems);
         switch(int($selectIndex))
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
      
      private function __makeBtnHandler(evt:MouseEvent) : void
      {
         var str:* = null;
         var priceArr:* = null;
         var i:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_materialsArr.length > 0)
         {
            str = "";
            priceArr = ServerConfigManager.instance.localYearFoodItemsPrices;
            for(i = 0; i < _materialsArr.length; )
            {
               var _loc5_:* = _materialsArr[i].id;
               if(0 !== _loc5_)
               {
                  if(1 !== _loc5_)
                  {
                     if(2 !== _loc5_)
                     {
                        if(3 === _loc5_)
                        {
                           str = str + ("Bột x" + _materialsArr[i].number + "  ");
                           _price = _price + int(priceArr[i]) * int(_materialsArr[i].number);
                        }
                     }
                     else
                     {
                        str = str + ("Trứng x" + _materialsArr[i].number + "  ");
                        _price = _price + int(priceArr[i]) * int(_materialsArr[i].number);
                     }
                  }
                  else
                  {
                     str = str + ("Bơ x" + _materialsArr[i].number + "  ");
                     _price = _price + int(priceArr[i]) * int(_materialsArr[i].number);
                  }
               }
               else
               {
                  str = str + ("Nến x" + _materialsArr[i].number + "  ");
                  _price = _price + int(priceArr[i]) * int(_materialsArr[i].number);
               }
               i++;
            }
            _alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceMainView.view.money",str,_price),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _alert1.addEventListener("response",__makeNewYearRice);
         }
         else
         {
            SocketManager.Instance.out.makeNewYearRice(0,_btnGroup.selectIndex,_materialsArr);
         }
      }
      
      private function __makeNewYearRice(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__makeNewYearRice);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
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
      
      private function _responseI(e:FrameEvent) : void
      {
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function showMaterials() : void
      {
         var i:int = 0;
         var sprite:* = null;
         var materialsBg:* = null;
         var materialsNum:* = null;
         for(i = 0; i < 4; )
         {
            sprite = new Sprite();
            materialsBg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.MaterialsBG" + i);
            materialsNum = ComponentFactory.Instance.creatBitmap("asset.newYearRice.MaterialsNumFrame");
            sprite.addChild(materialsNum);
            sprite.addChild(materialsBg);
            addToContent(sprite);
            PositionUtils.setPos(sprite,"NewYearRiceMainView.Materials" + i);
            i++;
         }
      }
      
      private function updateMaterialsText($currentArr:Array, $maxArr:Array) : void
      {
         var i:int = 0;
         var obj:* = null;
         _materialsArr = [];
         var k:int = 0;
         _materialsNum_1.text = $currentArr[0] + "/" + $maxArr[0];
         _materialsNum_2.text = $currentArr[1] + "/" + $maxArr[1];
         _materialsNum_3.text = $currentArr[2] + "/" + $maxArr[2];
         _materialsNum_4.text = $currentArr[3] + "/" + $maxArr[3];
         for(i = 0; i < $maxArr.length; )
         {
            if($currentArr[i] >= $maxArr[i])
            {
               switch(int(i))
               {
                  case 0:
                     _materialsNum_1.text = $currentArr[0] + "/" + $maxArr[0];
                     setTFStyle(_materialsNum_1);
                     break;
                  case 1:
                     _materialsNum_2.text = $currentArr[1] + "/" + $maxArr[1];
                     setTFStyle(_materialsNum_2);
                     break;
                  case 2:
                     _materialsNum_3.text = $currentArr[2] + "/" + $maxArr[2];
                     setTFStyle(_materialsNum_3);
                     break;
                  case 3:
                     _materialsNum_4.text = $currentArr[3] + "/" + $maxArr[3];
                     setTFStyle(_materialsNum_4);
               }
            }
            else
            {
               obj = {};
               obj.number = $maxArr[i] - $currentArr[i];
               obj.id = i;
               _materialsArr[k] = obj;
               k++;
            }
            i++;
         }
      }
      
      public function upDatafitCount(id:Array) : Array
      {
         var i:int = 0;
         var conut:int = 0;
         var arr:Array = [];
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         for(i = 0; i < id.length; )
         {
            conut = bagInfo.getItemCountByTemplateId(id[i]);
            arr.push(conut);
            i++;
         }
         return arr;
      }
      
      private function getMaterialsPrice(id:Array) : Array
      {
         var i:int = 0;
         var itemInfo:* = null;
         var arr:Array = [];
         for(i = 0; i < id.length; )
         {
            itemInfo = ItemManager.Instance.getTemplateById(id[i]) as ItemTemplateInfo;
            arr.push(itemInfo.Property3);
            i++;
         }
         return arr;
      }
      
      private function setTFStyle($txt:FilterFrameText) : void
      {
         var mytf:TextFormat = new TextFormat();
         mytf.color = [16374016];
         $txt.setTextFormat(mytf,0,$txt.length);
      }
      
      private function showGoods(idArr:Array) : void
      {
         var i:int = 0;
         var bg:* = null;
         var dx:Number = NaN;
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         var index:int = 0;
         var length:int = 0;
         for(i = 0; i < idArr.length; )
         {
            bg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.GoodsFrame");
            dx = bg.width + 15;
            dx = dx * (int(length % 6));
            bg.x = dx;
            bg.y = 243;
            itemInfo = ItemManager.Instance.getTemplateById(idArr[index].TemplateID) as ItemTemplateInfo;
            if(idArr[index].Quality != _btnGroup.selectIndex + 1)
            {
               index++;
            }
            else
            {
               tInfo = new InventoryItemInfo();
               ObjectUtils.copyProperties(tInfo,itemInfo);
               tInfo.ValidDate = idArr[index].ValidDate;
               tInfo.StrengthenLevel = idArr[index].StrengthLevel;
               tInfo.AttackCompose = idArr[index].AttackCompose;
               tInfo.DefendCompose = idArr[index].DefendCompose;
               tInfo.LuckCompose = idArr[index].LuckCompose;
               tInfo.AgilityCompose = idArr[index].AgilityCompose;
               tInfo.IsBinds = idArr[index].IsBind;
               tInfo.Count = idArr[index].Count;
               cell = new BagCell(0,tInfo,false);
               cell.x = dx + 6;
               cell.y = 249;
               cell.setBgVisible(false);
               _goodItemContainerAll.addChild(bg);
               _goodItemContainerAll.addChild(cell);
               index++;
               length++;
            }
            i++;
         }
         addToContent(_goodItemContainerAll);
      }
      
      private function __helpBtnHandler(evt:MouseEvent) : void
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
      
      private function __helpFrameRespose(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(event:MouseEvent) : void
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
