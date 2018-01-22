package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class KingDivisionConsortionListItem extends Sprite implements Disposeable
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _index:int;
      
      private var _consortionName:FilterFrameText;
      
      private var _points:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _ring:FilterFrameText;
      
      public function KingDivisionConsortionListItem(param1:int)
      {
         super();
         _index = param1;
         init();
      }
      
      private function init() : void
      {
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("kingDivision.consortionClub.MemberListItem");
         _index % 2 == 0?_itemBG.setFrame(2):_itemBG.setFrame(1);
         _consortionName = ComponentFactory.Instance.creatComponentByStylename("kingDivision.consortionName");
         _consortionName.text = "惶籽";
         _count = ComponentFactory.Instance.creatComponentByStylename("kingDivision.count");
         _count.text = "50";
         _points = ComponentFactory.Instance.creatComponentByStylename("kingDivision.points");
         _points.text = "3550";
         _level = ComponentFactory.Instance.creatComponentByStylename("kingDivision.level");
         _level.text = "10";
         _topThreeRink = ComponentFactory.Instance.creat("kingDivision.toffilist.topThreeRink");
         _topThreeRink.visible = false;
         _ring = ComponentFactory.Instance.creatComponentByStylename("kingDivision.ring");
         addChild(_itemBG);
         addChild(_consortionName);
         addChild(_count);
         addChild(_points);
         addChild(_level);
         addChild(_topThreeRink);
         addChild(_ring);
         setRink();
      }
      
      public function set info(param1:KingDivisionConsortionItemInfo) : void
      {
         _consortionName.text = String(param1.consortionName);
         _count.text = String(param1.num);
         _level.text = String(param1.consortionLevel);
         _points.text = String(param1.points);
      }
      
      private function setRink() : void
      {
         if(_index < 4)
         {
            _topThreeRink.visible = true;
            _topThreeRink.setFrame(_index);
            return;
         }
         _ring.text = _index + "th";
      }
      
      override public function get height() : Number
      {
         if(_itemBG == null)
         {
            return 0;
         }
         return _itemBG.y + _itemBG.height;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _itemBG = null;
         _consortionName = null;
         _count = null;
         _level = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
