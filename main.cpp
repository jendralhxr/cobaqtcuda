#include <QtCore/QCoreApplication>
#include <iostream>
using namespace std;
// the next 'include' is for CUDA error checks
#include <cuda_runtime.h>
// This is the 'elder trick of the...' - Tell the compiler this function is defined in other place
extern "C"
cudaError_t cuda_main();

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    // run your cuda application
    cudaError_t cuerr = cuda_main();
    // check for errors is always a good practice!
    if (cuerr != cudaSuccess) cout << "CUDA Error: " << cudaGetErrorString( cuerr ) << endl;

    return a.exec();
}
