package totem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   import trainer.view.NewHandContainer;
   
   public class TotemLeftWindowView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bgList:Vector.<Bitmap>;
      
      private var _totemPointBgList:Vector.<BitmapData>;
      
      private var _totemPointIconList:Vector.<BitmapData>;
      
      private var _totemPointSprite:Sprite;
      
      private var _totemPointList:Vector.<TotemLeftWindowTotemCell>;
      
      private var _curCanClickPointLocation:int;
      
      private var _totemPointLocationList:Array;
      
      private var _windowBorder:Bitmap;
      
      private var _lineShape:Shape;
      
      private var _lightGlowFilter:GlowFilter;
      
      private var _grayGlowFilter:ColorMatrixFilter;
      
      private var _openCartoonSprite:TotemLeftWindowOpenCartoonView;
      
      private var _propertyTxtSprite:TotemLeftWindowPropertyTxtView;
      
      private var _tipView:TotemPointTipView;
      
      private var _chapterIcon:TotemLeftWindowChapterIcon;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var confirmFrame:BaseAlerFrame;
      
      public function TotemLeftWindowView()
      {
         _totemPointLocationList = [[{
            "x":300,
            "y":300
         },{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":200,
            "y":200
         },{
            "x":300,
            "y":100
         },{
            "x":450,
            "y":150
         },{
            "x":450,
            "y":300
         }],[{
            "x":100,
            "y":100
         },{
            "x":100,
            "y":300
         },{
            "x":200,
            "y":200
         },{
            "x":300,
            "y":300
         },{
            "x":450,
            "y":300
         },{
            "x":450,
            "y":150
         },{
            "x":300,
            "y":100
         }],[{
            "x":100,
            "y":200
         },{
            "x":150,
            "y":100
         },{
            "x":250,
            "y":200
         },{
            "x":150,
            "y":300
         },{
            "x":350,
            "y":300
         },{
            "x":450,
            "y":200
         },{
            "x":350,
            "y":100
         }],[{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":250,
            "y":150
         },{
            "x":250,
            "y":300
         },{
            "x":400,
            "y":300
         },{
            "x":450,
            "y":200
         },{
            "x":350,
            "y":100
         }],[{
            "x":300,
            "y":300
         },{
            "x":200,
            "y":200
         },{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":300,
            "y":100
         },{
            "x":450,
            "y":300
         },{
            "x":450,
            "y":150
         }]];
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _windowBorder = ComponentFactory.Instance.creatBitmap("asset.totem.leftView.windowBorder");
         _windowBorder.smoothing = true;
         addChild(_windowBorder);
         _bgList = new Vector.<Bitmap>();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _bgList.push(ComponentFactory.Instance.creatBitmap("asset.totem.leftView.windowBg" + _loc1_));
            _loc1_++;
         }
         _totemPointBgList = new Vector.<BitmapData>();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _totemPointBgList.push(ComponentFactory.Instance.creatBitmapData("asset.totem.totemPointBg" + _loc1_));
            _loc1_++;
         }
         _totemPointIconList = new Vector.<BitmapData>();
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _totemPointIconList.push(ComponentFactory.Instance.creatBitmapData("asset.totem.totemPointIcon" + _loc1_));
            _loc1_++;
         }
         _openCartoonSprite = new TotemLeftWindowOpenCartoonView(_totemPointLocationList,refreshGlowFilter,refreshTotemPoint);
         _propertyTxtSprite = new TotemLeftWindowPropertyTxtView();
         _lineShape = new Shape();
         addChild(_lineShape);
         _lightGlowFilter = new GlowFilter(52479,1,20,20,2,2);
         _grayGlowFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _tipView = new TotemPointTipView();
         _tipView.visible = false;
         LayerManager.Instance.addToLayer(_tipView,2);
         _chapterIcon = ComponentFactory.Instance.creatCustomObject("totem.totemChapterIcon");
      }
      
      public function refreshView(param1:TotemDataVo, param2:Function = null) : void
      {
         _openCartoonSprite.refreshView(param1,param2);
      }
      
      public function openFailHandler(param1:TotemDataVo) : void
      {
         _openCartoonSprite.failRefreshView(param1,enableCurCanClickBtn);
      }
      
      private function enableCurCanClickBtn() : void
      {
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].mouseChildren = true;
            _totemPointList[_curCanClickPointLocation - 1].mouseEnabled = true;
         }
      }
      
      private function disenableCurCanClickBtn() : void
      {
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].mouseChildren = false;
            _totemPointList[_curCanClickPointLocation - 1].mouseEnabled = false;
         }
      }
      
      public function show(param1:int, param2:TotemDataVo, param3:Boolean) : void
      {
         if(param1 == 0)
         {
            param1 = 1;
         }
         if(_bg)
         {
            removeChild(_bg);
         }
         _bg = _bgList[param1 - 1];
         addChildAt(_bg,0);
         drawLine(param1,param2,param3);
         addTotemPoint(_totemPointLocationList[param1 - 1],param1,param2,param3);
         addChild(_openCartoonSprite);
         addChild(_propertyTxtSprite);
         addChild(_chapterIcon);
         _chapterIcon.show(param1);
      }
      
      private function addTotemPoint(param1:Array, param2:int, param3:TotemDataVo, param4:Boolean) : void
      {
         var _loc11_:int = 0;
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         if(_totemPointSprite)
         {
            if(_curCanClickPointLocation != 0 && _totemPointList)
            {
               _totemPointList[_curCanClickPointLocation - 1].useHandCursor = false;
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("click",openTotem);
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("mouseOver",showTip);
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("mouseOut",hideTip);
               _curCanClickPointLocation = 0;
            }
            if(_totemPointSprite.parent)
            {
               _totemPointSprite.parent.removeChild(_totemPointSprite);
            }
            _totemPointSprite = null;
         }
         if(_totemPointList)
         {
            var _loc13_:int = 0;
            var _loc12_:* = _totemPointList;
            for each(var _loc7_ in _totemPointList)
            {
               _loc7_.removeEventListener("mouseOver",showTip);
               _loc7_.removeEventListener("mouseOut",hideTip);
               ObjectUtils.disposeObject(_loc7_);
            }
            _totemPointList = null;
         }
         _totemPointSprite = new Sprite();
         _totemPointList = new Vector.<TotemLeftWindowTotemCell>();
         var _loc6_:BitmapData = _totemPointBgList[param2 - 1];
         var _loc10_:int = param1.length;
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            _loc9_ = new Bitmap(_loc6_,"auto",true);
            _loc5_ = new Bitmap(_totemPointIconList[_loc11_],"auto",true);
            _loc8_ = new TotemLeftWindowTotemCell(_loc9_,_loc5_);
            _loc8_.x = param1[_loc11_].x - 46;
            _loc8_.y = param1[_loc11_].y - 53;
            _loc8_.addEventListener("mouseOver",showTip,false,0,true);
            _loc8_.addEventListener("mouseOut",hideTip,false,0,true);
            _loc8_.index = _loc11_ + 1;
            _loc8_.isCurCanClick = false;
            _totemPointSprite.addChild(_loc8_);
            _totemPointList.push(_loc8_);
            _loc11_++;
         }
         _propertyTxtSprite.show(param1);
         refreshTotemPoint(param2,param3,param4);
         addChild(_totemPointSprite);
      }
      
      private function refreshGlowFilter(param1:int, param2:TotemDataVo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = _totemPointList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(!param2 || param1 < param2.Page || _loc4_ + 1 < param2.Location)
            {
               _totemPointList[_loc4_].setBgIconSpriteFilter([_lightGlowFilter]);
               _totemPointList[_loc4_].isHasLighted = true;
            }
            else
            {
               _totemPointList[_loc4_].setBgIconSpriteFilter([_grayGlowFilter]);
               _totemPointList[_loc4_].isHasLighted = false;
            }
            _loc4_++;
         }
      }
      
      private function refreshTotemPoint(param1:int, param2:TotemDataVo, param3:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         drawLine(param1,param2,param3);
         refreshGlowFilter(param1,param2);
         if(_curCanClickPointLocation != 0)
         {
            _loc6_ = _curCanClickPointLocation - 1;
            _totemPointList[_loc6_].dimOutHalo();
            _totemPointList[_loc6_].hideLigthCross();
            _totemPointList[_loc6_].removeEventListener("click",openTotem);
            _totemPointList[_loc6_].useHandCursor = false;
            _totemPointList[_loc6_].buttonMode = false;
            _totemPointList[_loc6_].mouseChildren = true;
            _totemPointList[_loc6_].mouseEnabled = true;
            _totemPointList[_loc6_].isCurCanClick = false;
            _curCanClickPointLocation = 0;
         }
         if(param3 && param2 && param1 == param2.Page)
         {
            _loc5_ = param2.Location - 1;
            _totemPointList[_loc5_].brightenHalo();
            _totemPointList[_loc5_].showLigthCross();
            _totemPointList[_loc5_].useHandCursor = true;
            _totemPointList[_loc5_].buttonMode = true;
            _totemPointList[_loc5_].mouseChildren = true;
            _totemPointList[_loc5_].mouseEnabled = true;
            _totemPointList[_loc5_].addEventListener("click",openTotem,false,0,true);
            _totemPointList[_loc5_].isCurCanClick = true;
            _curCanClickPointLocation = param2.Location;
         }
         if(!param2 || param1 < param2.Page)
         {
            _loc4_ = param1 * 10;
         }
         else
         {
            _loc4_ = (param1 - 1) * 10 + param2.Layers;
         }
         _propertyTxtSprite.refreshLayer(_loc4_);
         var _loc7_:int = _totemPointList.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _totemPointList[_loc8_].level = _loc4_;
            _loc8_++;
         }
      }
      
      public function scalePropertyTxtSprite(param1:Number) : void
      {
         if(_propertyTxtSprite)
         {
            _propertyTxtSprite.scaleTxt(param1);
         }
      }
      
      private function openTotem(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc6_:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         var _loc3_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
         if(DragonBoatManager.instance.isBuildEnd)
         {
            _loc2_ = Math.round(_loc6_.DiscountMoney);
         }
         else
         {
            _loc2_ = Math.round(_loc6_.ConsumeExp);
         }
         var _loc5_:int = _loc2_ - _loc3_;
         if(PlayerManager.Instance.Self.myHonor < _loc6_.ConsumeHonor || _loc3_ + PlayerManager.Instance.Self.Money < _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorOrExpUnenough"));
            return;
         }
         if(PlayerManager.Instance.Self.myHonor >= _loc6_.ConsumeHonor && _loc3_ < _loc2_ && PlayerManager.Instance.Self.Money >= _loc5_ && _loc3_ > 0)
         {
            if(!TotemManager.instance.isDonotPromptActPro)
            {
               if(PlayerManager.Instance.Self.myHonor < _loc6_.ConsumeHonor || _loc3_ + PlayerManager.Instance.Self.Money < _loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorOrExpUnenough"));
                  TotemManager.instance.isDonotPromptActPro = true;
               }
               else
               {
                  doOpenOneTotem(false);
                  return;
               }
            }
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.totem.activateProtectTipTxt3",_loc5_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            _loc4_.addToContent(_selectBtn);
            _loc4_.moveEnable = false;
            _loc4_.addEventListener("response",__openOneTotemConfirms);
            _loc4_.height = 200;
            _selectBtn.x = 32;
            _selectBtn.y = 67;
         }
         else
         {
            doOpenOneTotem(false);
         }
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         TotemManager.instance.isDonotPromptActPro = !_selectBtn.selected;
      }
      
      private function __openOneTotemConfirms(param1:FrameEvent) : void
      {
         var _loc2_:Number = NaN;
         SoundManager.instance.play("008");
         var _loc5_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc5_.removeEventListener("response",__openOneTotemConfirm);
         var _loc3_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
         var _loc4_:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         if(DragonBoatManager.instance.isBuildEnd)
         {
            _loc2_ = Math.round(_loc4_.DiscountMoney);
         }
         else
         {
            _loc2_ = Math.round(_loc4_.ConsumeExp);
         }
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc3_ + PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            doOpenOneTotem(false);
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            TotemManager.instance.isDonotPromptActPro = true;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__openOneTotemConfirms);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __openOneTotemConfirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__openOneTotemConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            if(_loc2_.Random < 100 && _loc3_.isBand && PlayerManager.Instance.Self.BandMoney < 1000)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               return;
            }
            if(_loc2_.Random < 100 && !_loc3_.isBand && PlayerManager.Instance.Self.Money < 1000)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc3_ as TotemActProConfirmFrame).isNoPrompt)
            {
               TotemManager.instance.isDonotPromptActPro = true;
               TotemManager.instance.isBindInNoPrompt = _loc3_.isBand;
            }
            doOpenOneTotem(_loc3_.isBand);
         }
      }
      
      private function doOpenOneTotem(param1:Boolean) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(101))
         {
            if(PlayerManager.Instance.Self.Grade >= 22)
            {
               SocketManager.Instance.out.syncWeakStep(101);
               NewHandContainer.Instance.clearArrowByID(145);
            }
         }
         disenableCurCanClickBtn();
         SocketManager.Instance.out.sendOpenOneTotem(TotemManager.instance.isSelectedActPro,param1);
      }
      
      private function showTip(param1:MouseEvent) : void
      {
         var _loc4_:TotemLeftWindowTotemCell = param1.currentTarget as TotemLeftWindowTotemCell;
         var _loc2_:Point = this.localToGlobal(new Point(_loc4_.x + _loc4_.bgIconWidth + 10,_loc4_.y));
         _tipView.x = _loc2_.x;
         _tipView.y = _loc2_.y;
         var _loc3_:TotemDataVo = TotemManager.instance.getCurInfoByLevel((_loc4_.level - 1) * 7 + _loc4_.index);
         _tipView.show(_loc3_,_loc4_.isCurCanClick,_loc4_.isHasLighted);
         _tipView.visible = true;
      }
      
      private function hideTip(param1:MouseEvent) : void
      {
         _tipView.visible = false;
      }
      
      private function drawTestPoint() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Shape = new Shape();
         _loc3_ = 1;
         while(_loc3_ <= 7)
         {
            _loc2_ = 1;
            while(_loc2_ <= 10)
            {
               _loc1_.graphics.beginFill(16711680,0.6);
               _loc1_.graphics.drawCircle(_loc2_ * 50,_loc3_ * 50,10);
               _loc1_.graphics.endFill();
               _loc2_++;
            }
            _loc3_++;
         }
         addChild(_loc1_);
      }
      
      private function drawLine(param1:int, param2:TotemDataVo, param3:Boolean) : void
      {
         var _loc6_:int = 0;
         _lineShape.graphics.clear();
         var _loc4_:Array = _totemPointLocationList[param1 - 1];
         var _loc5_:int = 0;
         if(!param2 || param1 < param2.Page)
         {
            _loc5_ = _loc4_.length;
         }
         else if(param3)
         {
            _loc5_ = param2.Location;
         }
         else
         {
            _loc5_ = param2.Location;
         }
         _lineShape.graphics.lineStyle(2.7,4321279,0.2);
         _lineShape.graphics.moveTo(_loc4_[0].x,_loc4_[0].y);
         _loc6_ = 1;
         while(_loc6_ < _loc5_)
         {
            _lineShape.graphics.lineTo(_loc4_[_loc6_].x,_loc4_[_loc6_].y);
            _loc6_++;
         }
         _lineShape.filters = [new GlowFilter(65532,1,8,8)];
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         var _loc5_:int = 0;
         var _loc4_:* = _totemPointBgList;
         for each(var _loc3_ in _totemPointBgList)
         {
            _loc3_.dispose();
         }
         _totemPointBgList = null;
         var _loc7_:int = 0;
         var _loc6_:* = _totemPointIconList;
         for each(var _loc1_ in _totemPointIconList)
         {
            _loc1_.dispose();
         }
         _totemPointIconList = null;
         _totemPointSprite = null;
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].useHandCursor = false;
            _totemPointList[_curCanClickPointLocation - 1].removeEventListener("click",openTotem);
            _curCanClickPointLocation = 0;
         }
         if(_totemPointList)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _totemPointList;
            for each(var _loc2_ in _totemPointList)
            {
               _loc2_.removeEventListener("mouseOver",showTip);
               _loc2_.removeEventListener("mouseOut",hideTip);
               ObjectUtils.disposeObject(_loc2_);
            }
         }
         _totemPointList = null;
         _lineShape = null;
         _lightGlowFilter = null;
         _grayGlowFilter = null;
         _bg = null;
         _bgList = null;
         _windowBorder = null;
         _propertyTxtSprite = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_openCartoonSprite);
         _openCartoonSprite = null;
         ObjectUtils.disposeObject(_chapterIcon);
         _chapterIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
