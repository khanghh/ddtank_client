package luckStar.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarAwardView extends Sprite implements Disposeable
   {
       
      
      private var bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _list:Vector.<BaseCell>;
      
      private var _countList:Vector.<FilterFrameText>;
      
      public function LuckStarAwardView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _countList = new Vector.<FilterFrameText>();
         bg = ComponentFactory.Instance.creat("luckyStar.view.AwardListBG");
         _closeBtn = ComponentFactory.Instance.creat("luckyStar.view.RankBtn");
         _closeBtn.addEventListener("click",__onClose);
         addChild(bg);
         addChild(_closeBtn);
         updateView();
      }
      
      private function updateView() : void
      {
         var quality:int = 0;
         var i:int = 0;
         var text:* = null;
         var qualityList:Array = [11,12,13,14,15,16];
         var awardList:Vector.<InventoryItemInfo> = LuckStarManager.Instance.model.reward;
         var len:int = awardList.length;
         var index:int = 0;
         _list = new Vector.<BaseCell>(len);
         while(qualityList.length)
         {
            quality = qualityList.shift();
            index = 0;
            for(i = 0; i < len; )
            {
               if(awardList[i].Quality == quality)
               {
                  _list[i] = new BaseCell(ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.awardcellBg"));
                  _list[i].info = awardList[i];
                  _list[i].info.Quality = ItemManager.Instance.getTemplateById(awardList[i].TemplateID).Quality;
                  PositionUtils.setPos(_list[i],"luckyStar.view.awardPos" + quality + index);
                  addChild(_list[i]);
                  if(awardList[i].Count > 1)
                  {
                     text = ComponentFactory.Instance.creat("luckyStar.view.cellCount");
                     text.text = awardList[i].Count.toString();
                     text.x = _list[i].x - 12;
                     text.y = _list[i].y + 25;
                     addChild(text);
                     _countList.push(text);
                  }
                  index++;
               }
               i++;
            }
         }
      }
      
      private function __onClose(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.parent.removeChild(this);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(bg);
         bg = null;
         _closeBtn.removeEventListener("click",__onClose);
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         while(_list.length)
         {
            ObjectUtils.disposeObject(_list.pop());
         }
         _list = null;
         while(_countList.length)
         {
            ObjectUtils.disposeObject(_countList.pop());
         }
         _countList = null;
      }
   }
}
