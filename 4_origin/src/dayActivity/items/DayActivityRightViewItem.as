package dayActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.DayRewaidData;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class DayActivityRightViewItem extends Sprite implements Disposeable
   {
       
      
      public var id:int;
      
      private var _back:ScaleBitmapImage;
      
      private var _txt1:FilterFrameText;
      
      private var _list:Vector.<BagCell>;
      
      private var _btn1:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _lightBitMap:MovieClip;
      
      public function DayActivityRightViewItem(num:int)
      {
         super();
         initView(num);
      }
      
      private function initView(num:int) : void
      {
         _list = new Vector.<BagCell>();
         _back = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.right.itemBack");
         addChild(_back);
         _lightBitMap = ComponentFactory.Instance.creat("day.receiveLight");
         _lightBitMap.x = 284;
         _lightBitMap.y = 13;
         _lightBitMap.visible = false;
         addChild(_lightBitMap);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.right.itemTxt");
         _txt1.text = LanguageMgr.GetTranslation("ddt.dayActivity.needActivity",num);
         addChild(_txt1);
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("dayActivity.day.receiveBtn");
         _btn1.addEventListener("click",clickHander);
         addChild(_btn1);
         _btn1.visible = false;
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("dayActivity.receiveOverBtn");
         _btn2.visible = false;
         addChild(_btn2);
         initGoods(DayActivityManager.Instance.reweadDataList,num);
      }
      
      private function clickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGetGoods(id);
      }
      
      public function showBtn(bool:Boolean) : void
      {
         _txt1.visible = false;
         _btn2.visible = false;
         _btn1.visible = false;
         _lightBitMap.visible = false;
         if(bool)
         {
            _btn2.visible = true;
            _btn2.enable = false;
            applyGray(this);
         }
         else
         {
            _btn1.visible = true;
            _btn1.enable = true;
            _lightBitMap.visible = true;
         }
      }
      
      private function applyGray(child:DisplayObject) : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         applyFilter(child,matrix);
      }
      
      private function applyFilter(child:DisplayObject, matrix:Array) : void
      {
         var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         var filters:Array = [];
         filters.push(filter);
         child.filters = filters;
      }
      
      private function initGoods(list:Vector.<DayRewaidData>, num:int) : void
      {
         var i:int = 0;
         var cell:* = null;
         var back:* = null;
         var info:* = null;
         if(!list)
         {
            return;
         }
         var len:int = list.length;
         var index:int = 0;
         for(i = 0; i < len; )
         {
            if(num == DayActivityManager.Instance.reweadDataList[i].RewardID)
            {
               cell = new BagCell(i);
               back = ComponentFactory.Instance.creat("dayActivityView.right.goodsBack");
               info = ItemManager.Instance.getTemplateById(DayActivityManager.Instance.reweadDataList[i].RewardItemID);
               cell.info = info;
               addChild(back);
               addChild(cell);
               back.x = (back.width + 4) * index + 10;
               back.y = _back.height / 2 - back.height / 2;
               cell.x = back.x + 2.5;
               cell.y = back.y + 2.5;
               index++;
               cell.setCount(DayActivityManager.Instance.reweadDataList[i].RewardItemCount);
               _list.push(cell);
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         _btn1.removeEventListener("click",clickHander);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _list = null;
      }
   }
}
