package starling.scene.consortiaDomain.buildView
{
   import road7th.DDTAssetManager;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class RepairAni extends Sprite
   {
       
      
      private var _isRepairing:Boolean;
      
      private var _aniImage:Image;
      
      private var _repairIcon:Image;
      
      private var _repairIconY:int;
      
      public function RepairAni()
      {
         super();
         var repairAniBg:Image = new Image(DDTAssetManager.instance.getTexture("consortiaDomainRepairAniBg"));
         addChild(repairAniBg);
         _repairIcon = new Image(DDTAssetManager.instance.getTexture("consortiaDomainRepairIcon1"));
         _repairIcon.x = 10;
         _repairIconY = 11;
         _repairIcon.y = _repairIconY;
         addChild(_repairIcon);
         _aniImage = new Image(DDTAssetManager.instance.getTexture("consortiaDomainRepairAni"));
         _aniImage.pivotX = _aniImage.width * 0.5;
         _aniImage.pivotY = _aniImage.height * 0.5;
         _aniImage.x = 28;
         _aniImage.y = 28;
         addChild(_aniImage);
      }
      
      public function startRepair() : void
      {
         if(_isRepairing)
         {
            return;
         }
         rotateRepairAni();
         downUpRepairIcon(true);
         _isRepairing = true;
      }
      
      private function rotateRepairAni() : void
      {
         _aniImage.rotation = 0;
         Starling.juggler.tween(_aniImage,1,{
            "rotation":3.14159265358979 * 2,
            "onComplete":rotateRepairAni
         });
      }
      
      private function downUpRepairIcon(isUp:Boolean) : void
      {
         if(isUp)
         {
            Starling.juggler.tween(_repairIcon,0.5,{
               "y":_repairIconY - 2,
               "onComplete":downUpRepairIcon,
               "onCompleteArgs":[false]
            });
         }
         else
         {
            Starling.juggler.tween(_repairIcon,0.5,{
               "y":_repairIconY,
               "onComplete":downUpRepairIcon,
               "onCompleteArgs":[true]
            });
         }
      }
      
      public function stopRepair() : void
      {
         if(!_isRepairing)
         {
            return;
         }
         _isRepairing = false;
         Starling.juggler.removeTweens(_aniImage);
         Starling.juggler.removeTweens(_repairIcon);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Starling.juggler.removeTweens(_aniImage);
         Starling.juggler.removeTweens(_repairIcon);
         _aniImage = null;
         _repairIcon = null;
      }
   }
}
