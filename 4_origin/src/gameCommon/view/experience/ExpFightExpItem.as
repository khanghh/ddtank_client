package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gameCommon.GameControl;
   
   public class ExpFightExpItem extends Sprite implements Disposeable
   {
       
      
      protected var _bg:Bitmap;
      
      protected var _titleBitmap:Bitmap;
      
      protected var _itemType:String;
      
      protected var _typeTxts:Vector.<ExpTypeTxt>;
      
      protected var _numTxt:ExpCountingTxt;
      
      protected var _step:int;
      
      protected var _value:Number;
      
      protected var _valueArr:Array;
      
      public function ExpFightExpItem(param1:Array)
      {
         super();
         _valueArr = param1;
         init();
      }
      
      protected function init() : void
      {
         _itemType = "fightingExp";
         PositionUtils.setPos(this,"experience.FightingExpItemPos");
         _bg = ComponentFactory.Instance.creatBitmap("asset.experience.fightExpItemBg");
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.experience.fightExpItemTitle");
      }
      
      public function createView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("experience.txtStartPos");
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("experience.txtOffset");
         PositionUtils.setPos(_bg,"experience.ItemBgPos");
         _typeTxts = new Vector.<ExpTypeTxt>();
         addChild(_bg);
         addChild(_titleBitmap);
         _step = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = _itemType == "fightingExp"?4:Number(_itemType == "attatchExp"?9:6);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            if(_itemType == "attatchExp" && (_loc6_ == 1 || _loc6_ == 7) && GameControl.Instance.Current.roomType != 0 && GameControl.Instance.Current.roomType != 1 && GameControl.Instance.Current.roomType != 16 && GameControl.Instance.Current.roomType != 18)
            {
               _loc4_++;
            }
            else
            {
               _typeTxts.push(new ExpTypeTxt(_itemType,_loc6_,_valueArr[_loc6_ - _loc4_]));
               if(_loc5_ % 2 == 0 && _loc5_ != 8)
               {
                  _loc3_.y = _loc3_.y + _loc1_.y;
                  _typeTxts[_loc5_].y = _loc3_.y + _loc1_.y;
               }
               else
               {
                  _typeTxts[_loc5_].y = _loc3_.y;
                  _typeTxts[_loc5_].x = _loc3_.x + _loc1_.x;
               }
               _typeTxts[_loc5_].addEventListener("change",__updateText);
               addChild(_typeTxts[_loc5_]);
               _loc5_++;
            }
            _loc6_++;
         }
         createNumTxt();
      }
      
      protected function createNumTxt() : void
      {
         _numTxt = new ExpCountingTxt("experience.expCountTxt","experience.expTxtFilter_1,experience.expTxtFilter_2");
         _numTxt.addEventListener("change",__onTextChange);
         addChild(_numTxt);
      }
      
      private function __updateText(param1:Event = null) : void
      {
         _numTxt.updateNum(param1.currentTarget.value);
      }
      
      protected function __onTextChange(param1:Event) : void
      {
         _value = param1.currentTarget.targetValue;
         dispatchEvent(new Event("change"));
      }
      
      public function get targetValue() : Number
      {
         return _numTxt.targetValue;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         if(_numTxt)
         {
            _numTxt.removeEventListener("change",__onTextChange);
            _numTxt.dispose();
            _numTxt = null;
         }
         var _loc1_:int = _typeTxts.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _typeTxts[_loc2_].removeEventListener("change",__updateText);
            _typeTxts[_loc2_].dispose();
            _typeTxts[_loc2_] = null;
            _loc2_++;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_titleBitmap)
         {
            ObjectUtils.disposeObject(_titleBitmap);
            _titleBitmap = null;
         }
         _valueArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
