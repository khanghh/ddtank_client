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
      
      public function ExpFightExpItem(arr:Array)
      {
         super();
         _valueArr = arr;
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
         var i:int = 0;
         var txtPos:Point = ComponentFactory.Instance.creatCustomObject("experience.txtStartPos");
         var txtOffset:Point = ComponentFactory.Instance.creatCustomObject("experience.txtOffset");
         PositionUtils.setPos(_bg,"experience.ItemBgPos");
         _typeTxts = new Vector.<ExpTypeTxt>();
         addChild(_bg);
         addChild(_titleBitmap);
         _step = 0;
         var k:int = 0;
         var skip:int = 0;
         var len:int = _itemType == "fightingExp"?4:Number(_itemType == "attatchExp"?9:6);
         for(i = 0; i < len; )
         {
            if(_itemType == "attatchExp" && (i == 1 || i == 7) && GameControl.Instance.Current.roomType != 0 && GameControl.Instance.Current.roomType != 1 && GameControl.Instance.Current.roomType != 16 && GameControl.Instance.Current.roomType != 18)
            {
               skip++;
            }
            else
            {
               _typeTxts.push(new ExpTypeTxt(_itemType,i,_valueArr[i - skip]));
               if(k % 2 == 0 && k != 8)
               {
                  txtPos.y = txtPos.y + txtOffset.y;
                  _typeTxts[k].y = txtPos.y + txtOffset.y;
               }
               else
               {
                  _typeTxts[k].y = txtPos.y;
                  _typeTxts[k].x = txtPos.x + txtOffset.x;
               }
               _typeTxts[k].addEventListener("change",__updateText);
               addChild(_typeTxts[k]);
               k++;
            }
            i++;
         }
         createNumTxt();
      }
      
      protected function createNumTxt() : void
      {
         _numTxt = new ExpCountingTxt("experience.expCountTxt","experience.expTxtFilter_1,experience.expTxtFilter_2");
         _numTxt.addEventListener("change",__onTextChange);
         addChild(_numTxt);
      }
      
      private function __updateText(event:Event = null) : void
      {
         _numTxt.updateNum(event.currentTarget.value);
      }
      
      protected function __onTextChange(event:Event) : void
      {
         _value = event.currentTarget.targetValue;
         dispatchEvent(new Event("change"));
      }
      
      public function get targetValue() : Number
      {
         return _numTxt.targetValue;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         if(_numTxt)
         {
            _numTxt.removeEventListener("change",__onTextChange);
            _numTxt.dispose();
            _numTxt = null;
         }
         var len:int = _typeTxts.length;
         for(i = 0; i < len; )
         {
            _typeTxts[i].removeEventListener("change",__updateText);
            _typeTxts[i].dispose();
            _typeTxts[i] = null;
            i++;
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
