package ddtBuried.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ShowCard extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _list:Vector.<BagCell>;
      
      public function ShowCard()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _list = new Vector.<BagCell>();
         _mc = ComponentFactory.Instance.creat("buried.card.show");
         addChild(_mc);
         _mc.addFrameScript(69,cradOver);
         _mc.addFrameScript(10,intCardShow);
      }
      
      private function intCardShow() : void
      {
         var i:int = 0;
         var obj:* = null;
         var info:* = null;
         var cell:* = null;
         var len:int = BuriedManager.Instance.cardInitList.length;
         for(i = 0; i < len; )
         {
            obj = {};
            obj.tempID = BuriedManager.Instance.cardInitList[i].tempID;
            obj.count = BuriedManager.Instance.cardInitList[i].count;
            info = ItemManager.Instance.getTemplateById(obj.tempID);
            cell = new BagCell(0,info);
            cell.x = 39;
            cell.y = 107;
            cell.setBgVisible(false);
            cell.setCount(obj.count);
            _mc["card" + (i + 1)].addChild(cell);
            _list.push(cell);
            _mc["card" + (i + 1)].goodsName.text = info.Name;
            i++;
         }
      }
      
      private function clearCell() : void
      {
         var i:int = 0;
         for(i = 0; i < _list.length; )
         {
            _list[i].dispose();
            ObjectUtils.disposeObject(_list[i]);
            _list[i] = null;
            while(_mc["card" + (i + 1)].numChildren)
            {
               ObjectUtils.disposeObject(_mc["card" + (i + 1)].getChildAt(0));
            }
            i++;
         }
      }
      
      public function play() : void
      {
         _mc.play();
      }
      
      public function resetFrame() : void
      {
         _mc.gotoAndStop(1);
      }
      
      private function cradOver() : void
      {
         _mc.stop();
         BuriedControl.Instance.dispatchEvent(new BuriedEvent("card_show_over"));
      }
      
      public function dispose() : void
      {
         if(_list)
         {
            clearCell();
         }
         if(_mc)
         {
            _mc.stop();
            while(_mc.numChildren)
            {
               ObjectUtils.disposeObject(_mc.getChildAt(0));
            }
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _mc = null;
         _list = null;
      }
   }
}
