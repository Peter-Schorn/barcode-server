
#  exit the script if any command exits with a non-zero exit code
set -e

echo "====== Deploying Barcode Server ======"
echo

registery=947734355387.dkr.ecr.us-east-1.amazonaws.com

aws ecr get-login-password --region us-east-1 | \
    docker login --username AWS --password-stdin $registery

docker build -t barcode-server .

name_tag="barcode-server:latest"

docker tag $name_tag $registery/$name_tag

docker push $registery/$name_tag

# deploy to elastic beanstalk

cd eb

echo
echo "====== Deploying to Elastic Beanstalk ======"
echo

eb deploy
