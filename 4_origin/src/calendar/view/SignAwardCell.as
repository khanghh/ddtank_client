package calendar.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class SignAwardCell extends BaseCell
   {
       
      
      private var _bigBack:DisplayObject;
      
      private var _nameField:FilterFrameText;
      
      private var _tbxCount:FilterFrameText;
      
      public function SignAwardCell()
      {
         super(ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.SignedAward.CellBack"));
         _bigBack = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.SignedAward.SignAwardCellBg");
         addChildAt(_bigBack,0);
         _nameField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.AwardNameField");
         addChild(_nameField);
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.SignedAwardCellCount");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      public function setCount(param1:int) : void
      {
         if(param1 > 0)
         {
            _tbxCount.text = param1.toString();
         }
         else
         {
            _tbxCount.text = "";
         }
         _tbxCount.x = 49 - _tbxCount.width;
         _tbxCount.y = 49 - _tbxCount.height;
         setChildIndex(_tbxCount,numChildren - 1);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _picPos = ComponentFactory.Instance.creatCustomObject("ddtcalendar.Award.pic.TopLeft");
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_info)
         {
            _nameField.text = _info.Name;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bigBack);
         _bigBack = null;
         ObjectUtils.disposeObject(_tbxCount);
         _tbxCount = null;
         super.dispose();
      }
   }
}
