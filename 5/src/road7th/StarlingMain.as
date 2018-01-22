package road7th
{
import com.demonsters.debugger.MonsterDebugger;
import com.pickgliss.ui.ComponentFactory;
import flash.display.BitmapData;
import flash.filters.BitmapFilterQuality;
import flash.geom.Point;
import flash.geom.Rectangle;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.ResizeEvent;
import starling.filters.BlurFilter;
import starling.scene.Scene;
import starling.textures.Texture;

public class StarlingMain extends Sprite
{

    private static var _instance:StarlingMain;


    public var currentScene:Scene;

    public function StarlingMain()
    {
        super();
        _instance = this;
        initAsset();
        MonsterDebugger.initialize(this);
    }

    public static function get instance() : StarlingMain
    {
        if(!_instance)
        {
            _instance = new StarlingMain();
        }
        return _instance;
    }

    private function initAsset() : void
    {
        DDTAssetManager.instance.addTexture("default",Texture.fromBitmapData(new BitmapData(2,2,false,0),false));
    }

    public function onStarlingCreate() : void
    {
        Starling.current.stage.addEventListener("resize",onStageResize);
    }

    private function onStageResize(param1:ResizeEvent) : void
    {
        var _loc2_:int = param1.width;
        var _loc3_:int = param1.height;
        Starling.current.viewPort = new Rectangle(0,0,_loc2_,_loc3_);
        if(StarlingPre.stageWidth == 0)
        {
            StarlingPre.originalWidth = _loc2_;
            StarlingPre.originalHeight = _loc3_;
        }
        else
        {
            StarlingPre.originalWidth = StarlingPre.stageWidth;
            StarlingPre.originalHeight = StarlingPre.stageHeight;
        }
        StarlingPre.stageWidth = _loc2_;
        StarlingPre.stageHeight = _loc3_;
        Starling.current.stage.stageWidth = _loc2_;
        Starling.current.stage.stageHeight = _loc3_;
    }

    public function leaveCurrentScene() : void
    {
        currentScene && currentScene.leaving();
        currentScene = null;
    }

    public function enterScene(param1:Scene) : void
    {
        currentScene && currentScene.leaving();
        currentScene = param1;
        if(currentScene)
        {
            currentScene.enter();
            addChild(currentScene);
        }
    }

    public function createImage(param1:String = "default", param2:* = null) : Image
    {
        var _loc5_:* = null;
        var _loc4_:* = null;
        var _loc6_:* = null;
        var _loc3_:Texture = DDTAssetManager.instance.getTexture(param1);
        if(_loc3_)
        {
            _loc5_ = new Image(_loc3_);
        }
        else
        {
            _loc4_ = null;
            try
            {
                _loc4_ = ComponentFactory.Instance.creatBitmapData(param1);
            }
            catch(e:Error)
            {
                _loc4_ = null;
            }
            if(_loc4_ == null)
            {
                trace("create starling Image Error: styleName : " + param1);
                _loc5_ = new Image(DDTAssetManager.instance.getTexture("default"));
            }
            else
            {
                _loc3_ = Texture.fromBitmapData(_loc4_);
                DDTAssetManager.instance.addTexture(param1,_loc3_,"default");
                _loc5_ = new Image(_loc3_);
                trace("create starling Image by ComponentFactiory : " + param1);
            }
        }
        if(param2 != null)
        {
            if(param2 is String)
            {
                _loc6_ = ComponentFactory.Instance.creatCustomObject(param2);
                _loc5_.x = _loc6_.x;
                _loc5_.y = _loc6_.y;
            }
            else if(param2 is Object)
            {
                _loc5_.x = param2.x;
                _loc5_.y = param2.y;
            }
        }
        _loc5_.touchable = false;
        return _loc5_;
    }


}
}
