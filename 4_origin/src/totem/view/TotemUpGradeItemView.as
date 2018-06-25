package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import totem.data.TotemUpGradDataVo;
   import totem.mornUI.TotemUpGradeItemViewUI;
   
   public class TotemUpGradeItemView extends TotemUpGradeItemViewUI
   {
       
      
      private var _info:TotemUpGradDataVo;
      
      private var _name:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _hBox:HBox;
      
      public function TotemUpGradeItemView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _hBox = ComponentFactory.Instance.creatComponentByStylename("totem.upGrades.totemNameSpri");
         addChild(_hBox);
         PositionUtils.setPos(_hBox,"totem.upGrade.nameSpriPos");
         _name = ComponentFactory.Instance.creatComponentByStylename("Totem.upGrades.chapterName");
         _name.setFrame(1);
         _hBox.addChild(_name);
         _grade = ComponentFactory.Instance.creatComponentByStylename("totem.upGrades.addGrade");
         _hBox.addChild(_grade);
      }
      
      public function update(info:TotemUpGradDataVo) : void
      {
         _info = info;
         updateView();
      }
      
      private function updateView() : void
      {
         if(_info == null)
         {
            throw new Error("图腾升阶数据异常");
         }
         var grade:int = _info.grades == 0?0:Number((_info.grades - 1) % 5 + 1);
         var frameLayer:int = Math.max(0,_info.grades - 1) / 5 + 1;
         chapter_item.clip_cell.index = frameLayer - 1;
         chapter_item.clip_chaampter.index = _info.templateId - 1;
         _name.text = _info.templateName;
         _name.setFrame(frameLayer);
         _grade.text = "+" + grade;
         lbl_addPer.text = _info.data / 10 + "%";
         _hBox.refreshChildPos();
         _hBox.x = (130 - _hBox.width) / 2 - 16;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_grade);
         _grade = null;
      }
   }
}
