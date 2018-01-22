package fightLib.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class FightLibAwardView extends Component implements Disposeable
   {
      
      private static const P_backColor:String = "P_backColor";
      
      private static const ColumnCount:int = 5;
       
      
      private var _gift:int;
      
      private var _exp:int;
      
      private var _medal:int;
      
      private var _items:Array;
      
      private var _awardTextField:FilterFrameText;
      
      private var _backColor:int = 0;
      
      private var _hasGeted:Boolean = false;
      
      private var _list:SimpleTileList;
      
      private var _scrollPane:ScrollPanel;
      
      private var _title:Bitmap;
      
      private var _geted:Bitmap;
      
      private var _maskShape:Sprite;
      
      private var _TipsText:Bitmap;
      
      private var _cells:Array;
      
      public function FightLibAwardView()
      {
         _cells = [];
         super();
      }
      
      public function set backColor(param1:int) : void
      {
         _backColor = param1;
         onPropertiesChanged("P_backColor");
      }
      
      public function get backColor() : int
      {
         return _backColor;
      }
      
      override public function draw() : void
      {
         super.draw();
      }
      
      override public function dispose() : void
      {
         if(_awardTextField)
         {
            ObjectUtils.disposeObject(_awardTextField);
            _awardTextField = null;
         }
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
            _list = null;
         }
         if(_scrollPane)
         {
            ObjectUtils.disposeObject(_scrollPane);
            _list = null;
         }
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         if(_geted)
         {
            ObjectUtils.disposeObject(_geted);
            _geted = null;
         }
         if(_TipsText)
         {
            ObjectUtils.disposeObject(_TipsText);
            _TipsText = null;
         }
         super.dispose();
      }
      
      override protected function init() : void
      {
         super.init();
         _awardTextField = ComponentFactory.Instance.creatComponentByStylename("fightLib.Award.AwardTextField");
         addChild(_awardTextField);
         _scrollPane = ComponentFactory.Instance.creatComponentByStylename("fightLib.Award.AwardScrollPanel");
         addChild(_scrollPane);
         _list = new SimpleTileList(2);
         _list.hSpace = 105;
         _list.vSpace = 23;
         _scrollPane.setView(_list);
         _geted = ComponentFactory.Instance.creatBitmap("fightLib.Award.Geted");
         addChild(_geted);
         _title = ComponentFactory.Instance.creatBitmap("fightLib.Award.Title");
         addChild(_title);
         _TipsText = ComponentFactory.Instance.creatBitmap("fightLib.Award.TipsText");
         addChild(_TipsText);
         _maskShape = new Sprite();
         _maskShape.graphics.beginFill(0,0.6);
         _maskShape.graphics.drawRoundRect(5,5,309,323,15,15);
         _maskShape.graphics.endFill();
         addChild(_maskShape);
         _maskShape.visible = false;
      }
      
      private function drawBackground() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         _loc1_.beginFill(_backColor,0.4);
         _loc1_.drawRoundRect(0,0,_width <= 0?1:Number(_width),_height <= 0?1:Number(_height),4,4);
         _loc1_.endFill();
      }
      
      public function setGiftAndExpNum(param1:int, param2:int, param3:int) : void
      {
         _gift = param1;
         _exp = param2;
         _medal = param3;
         updateTxt();
      }
      
      public function setAwardItems(param1:Array) : void
      {
         _items = param1;
         updateList();
      }
      
      private function updateTxt() : void
      {
         _awardTextField.text = "";
         if(_exp > 0)
         {
            _awardTextField.appendText(LanguageMgr.GetTranslation("exp") + _exp.toString());
         }
         if(_gift > 0)
         {
            if(_exp > 0)
            {
               _awardTextField.appendText(" ,");
            }
            _awardTextField.appendText(LanguageMgr.GetTranslation("gift") + _gift.toString());
         }
      }
      
      private function updateList() : void
      {
         var _loc1_:* = null;
         var _loc2_:AwardCell = _cells.shift();
         while(_loc2_ != null)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = _cells.shift();
         }
         var _loc5_:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Award.AwardList.cell.PicPos");
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Award.AwardList.cell.ContentSize");
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(var _loc3_ in _items)
         {
            _loc1_ = ItemManager.Instance.getTemplateById(_loc3_.id);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("fightLib.Award.AwardList.cell");
            _loc2_.info = _loc1_;
            _loc2_.count = _loc3_.count;
            _list.addChild(_loc2_);
            _cells.push(_loc2_);
         }
      }
      
      public function set geted(param1:Boolean) : void
      {
         if(_hasGeted != param1)
         {
            _hasGeted = param1;
            var _loc2_:* = _hasGeted;
            _geted.visible = _loc2_;
            _maskShape.visible = _loc2_;
         }
      }
      
      public function get geted() : Boolean
      {
         return _hasGeted;
      }
   }
}
