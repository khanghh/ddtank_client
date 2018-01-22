package academy.view
{
   import academy.AcademyController;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AcademyView extends Sprite implements Disposeable
   {
       
      
      private var _memberLis:AcademyMemberListView;
      
      private var _playerPanel:AcademyPlayerPanel;
      
      private var _controller:AcademyController;
      
      private var _flowerPatternBg:MovieClip;
      
      public function AcademyView(param1:AcademyController)
      {
         super();
         _controller = param1;
         init();
      }
      
      private function init() : void
      {
         _flowerPatternBg = ClassUtils.CreatInstance("asset.ddtAcademy.bigBg") as MovieClip;
         PositionUtils.setPos(_flowerPatternBg,"asset.ddtAcademy.bigBgPos");
         addChild(_flowerPatternBg);
         _memberLis = new AcademyMemberListView(_controller);
         PositionUtils.setPos(_memberLis,"academy.view.AcademyMemberListViewPos");
         addChild(_memberLis);
         _playerPanel = new AcademyPlayerPanel(_controller);
         addChild(_playerPanel);
      }
      
      public function dispose() : void
      {
         if(_memberLis)
         {
            _memberLis.dispose();
            _memberLis = null;
         }
         if(_playerPanel)
         {
            _playerPanel.dispose();
            _playerPanel = null;
         }
         if(_flowerPatternBg)
         {
            ObjectUtils.disposeObject(_flowerPatternBg);
            _flowerPatternBg = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
