package yyvip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yyvip.YYVipControl;
   
   public class YYVipLevelAwardCell extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _itemList:Vector.<YYVipLevelAwardItemCell>;
      
      public function YYVipLevelAwardCell(index:int)
      {
         var i:int = 0;
         var cell:* = null;
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.yyvip.levelIcon" + index);
         _txt = ComponentFactory.Instance.creatComponentByStylename("yyvip.levelAwardCell.tipTxt");
         _txt.text = LanguageMgr.GetTranslation("yyVip.dailyView.levelAwardCell.tipTxt",index);
         addChild(_icon);
         addChild(_txt);
         _itemList = new Vector.<YYVipLevelAwardItemCell>();
         var tmp:Vector.<Object> = YYVipControl.instance.getDailyLevelVipAwardList(index);
         var len:int = tmp.length;
         for(i = 0; i < len; )
         {
            cell = new YYVipLevelAwardItemCell(tmp[i]);
            cell.x = 170 + i * 108;
            cell.y = -1;
            addChild(cell);
            _itemList.push(cell);
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _txt = null;
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
